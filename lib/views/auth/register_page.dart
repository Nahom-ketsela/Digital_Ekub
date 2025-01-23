import 'package:flutter/material.dart';
import 'package:ekub/core/constants/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  static String route = 'signup-page';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Local storage and Firebase authentication instance
  final GetStorage _storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // State variables for password visibility and form validation
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  // Controllers for user input fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Error messages for validation feedback
  String? _emailError;
  String? _passwordError;
  String? _firebaseError;

  @override
  void dispose() {
    // Dispose of controllers to free resources
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validates the email field for correct format and non-emptiness
  void _validateEmail() {
    final email = _emailController.text.trim();
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email';
      });
    } else if (!emailRegex.hasMatch(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }
  }

  // Validates the password field for strength and non-emptiness
  void _validatePassword() {
    final password = _passwordController.text.trim();
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}\$');
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password';
      });
    } else if (!passwordRegex.hasMatch(password)) {
      setState(() {
        _passwordError =
            'Password must be at least 8 characters long, include uppercase, lowercase, a number, and a special character';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  // Checks if the form is valid based on current input and validation results
  bool get _isFormValid {
    return _emailError == null &&
        _passwordError == null &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  // Handles user registration using Firebase authentication
  Future<void> _signup() async {
    if (!_isFormValid) {
      return; // Exit if form is invalid
    }

    try {
      // Firebase Authentication: Create user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save user data locally upon successful registration
      _storage.write('email', userCredential.user?.email);
      _storage.write('loggedIn', true);

      // Navigate to the main screen
      Get.toNamed('mainscreen-page');
    } catch (e) {
      // Set the Firebase error message for display
      setState(() {
        _firebaseError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_firebaseError != null) ...[
                      Text(
                        _firebaseError!,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 10),
                    ],
                    Stack(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: null,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 227, 227, 227),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            errorText: _emailError,
                          ),
                          onChanged: (value) {
                            _validateEmail();
                          },
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 8,
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                              color: _emailController.text.isEmpty
                                  ? Colors.black
                                  : Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: null,
                            errorText: _passwordError,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 227, 227, 227),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          onChanged: (value) {
                            _validatePassword();
                          },
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 8,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: _passwordController.text.isEmpty
                                  ? Colors.black
                                  : Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isFormValid ? _signup : null,
                      child: Center(
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(335, 56),
                        backgroundColor: _isFormValid
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                        foregroundColor:
                            _isFormValid ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('login-page');
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
