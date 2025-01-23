import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  static String route = 'profile-page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final TextEditingController _newPasswordController = TextEditingController();

  bool _isEmailEditable = false;

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    _emailController = TextEditingController(text: user?.email ?? '');
    _passwordController =
        TextEditingController(); // Password won't be pre-filled
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileField(
                label: 'Email',
                controller: _emailController,
                isEditable: _isEmailEditable,
                onEditToggle: () async {
                  setState(() {
                    _isEmailEditable = !_isEmailEditable;
                  });
                  if (!_isEmailEditable) {
                    try {
                      await _auth.currentUser
                          ?.updateEmail(_emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email updated successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update email: $e')),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              _buildPasswordChangeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditable,
    required VoidCallback onEditToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                enabled: isEditable,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(isEditable ? Icons.check_circle : Icons.edit),
              color: isEditable ? Colors.green : Colors.grey[600],
              onPressed: onEditToggle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordChangeButton() {
    return ElevatedButton(
      onPressed: _changePassword,
      child: Text('Change Password'),
    );
  }

  void _changePassword() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                final user = _auth.currentUser;
                final cred = EmailAuthProvider.credential(
                  email: user!.email!,
                  password: _passwordController.text,
                );
                await user.reauthenticateWithCredential(cred);
                await user.updatePassword(_newPasswordController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password updated successfully!')),
                );
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update password: $e')),
                );
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
