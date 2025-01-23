import 'package:ekub/views/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:ekub/core/constants/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String route = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Local storage and Firebase authentication instance
  final GetStorage _storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // State variables for password visibility and form validation
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  bool _emailTouched = false;
  bool _passwordTouched = false;

  // Controllers for user input fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Error messages for validation feedback
  String? _emailError;
  String? _passwordError;
  String? _firebaseError; // To display Firebase errors

  @override
  void initState() {
    super.initState();
    // Listener to validate email whenever the user types
    _emailController.addListener(() {
      _emailTouched = true;
      _validateEmail();
    });
    // Listener to validate password whenever the user types
    _passwordController.addListener(() {
      _passwordTouched = true;
      _validatePassword();
    });
  }

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
    if (_emailTouched) {
      if (email.isEmpty) {
        setState(() {
          _emailError = 'Email is required.';
        });
      } else if (!emailRegex.hasMatch(email)) {
        setState(() {
          _emailError = 'Enter a valid email address.';
        });
      } else {
        setState(() {
          _emailError = null;
        });
      }
    }
  }

  // Validates the password field for strength and non-emptiness
  void _validatePassword() {
    final password = _passwordController.text.trim();
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}\$');
    if (_passwordTouched) {
      if (password.isEmpty) {
        setState(() {
          _passwordError = 'Password is required.';
        });
      } else if (!passwordRegex.hasMatch(password)) {
        setState(() {
          _passwordError =
              'Password must be at least 8 characters long, include uppercase, lowercase, a number, and a special character.';
        });
      } else {
        setState(() {
          _passwordError = null;
        });
      }
    }
  }

  // Handles login using Firebase authentication
  Future<void> _loginWithFirebase() async {
    if (!_formKey.currentState!.validate()) {
      return; // Exit if form is invalid
    }

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data locally upon successful login
      _storage.write('email', userCredential.user?.email);
      _storage.write('loggedIn', true);

      // Navigate to the main screen
      Get.toNamed('mainscreen-page');
    } catch (e) {
      // Set the Firebase error message for display
      setState(() {
        _firebaseError = _getFirebaseErrorMessage(e);
      });
    }
  }

  // Maps FirebaseAuthException codes to user-friendly messages
  String _getFirebaseErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'network-request-failed':
          return 'Network error. Please check your internet connection.';
        default:
          return 'An unexpected error occurred. Please try again later.';
      }
    }
    return 'An unexpected error occurred.';
  }

  // Checks if the form is valid based on current input and validation results
  bool get _isFormValid {
    return _emailError == null &&
        _passwordError == null &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 100),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Welcome to Digital ዕቁብ',
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        ' Saving App',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Hello there, login to continue',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                                SizedBox(height: 30),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 227, 227, 227),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 227, 227, 227),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                              _obscurePassword =
                                                  !_obscurePassword;
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
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 8,
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                          color:
                                              _passwordController.text.isEmpty
                                                  ? Colors.black
                                                  : Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_firebaseError != null) ...[
                                  SizedBox(height: 10),
                                  Text(
                                    _firebaseError!,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                                SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: _isFormValid
                                      ? () {
                                          _loginWithFirebase();
                                        }
                                      : null,
                                  child: Center(
                                    child: Text(
                                      'Login',
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
                                    foregroundColor: _isFormValid
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          'Or continue with social account',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Container(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                        'assets/images/google.png',
                                        fit: BoxFit.contain),
                                  ),
                                  label: Text(
                                    'Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 227, 227, 227),
                                        width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(double.infinity, 55),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.offAll(() => SignupPage());
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'Create an account? ',
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
