import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  static String route = 'profile-page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GetStorage storage = GetStorage();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _isEmailEditable = false;
  bool _isPasswordEditable = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: storage.read('email') ?? '');
    _passwordController =
        TextEditingController(text: storage.read('password') ?? '');
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
                onEditToggle: () {
                  setState(() {
                    _isEmailEditable = !_isEmailEditable;
                    if (!_isEmailEditable) {
                      storage.write('email', _emailController.text);
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              _buildProfileField(
                label: 'Password',
                controller: _passwordController,
                isEditable: _isPasswordEditable,
                onEditToggle: () {
                  setState(() {
                    _isPasswordEditable = !_isPasswordEditable;
                    if (!_isPasswordEditable) {
                      storage.write('password', _passwordController.text);
                    }
                  });
                },
              ),
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
                obscureText: label == 'Password' ? true : false,
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
}
