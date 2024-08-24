import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth for authentication
import 'home.dart'; // Import the Home Page
import 'signup.dart'; // Import the Sign Up Page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Controllers to manage text input for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Key to manage the form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

  // Variable to hold error messages
  String? _errorMessage;

  // Function to handle login
  Future<void> _login() async {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      try {
        // Attempt to sign in with email and password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Check if the widget is still mounted before navigating
        if (mounted) {
          // Navigate to the Home Page after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } catch (e) {
        // Handle error and display user-friendly message
        setState(() {
          _errorMessage = 'Login failed. Please check your credentials and try again.';
        });
      }
    }
  }

  // Function to handle password reset
  Future<void> _resetPassword() async {
    // Check if the email field is empty
    if (_emailController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your email to reset your password.';
      });
      return;
    }

    try {
      // Send a password reset email
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      setState(() {
        _errorMessage = 'Password reset email sent! Check your inbox.';
      });
    } catch (e) {
      // Handle error for password reset
      setState(() {
        _errorMessage = 'Failed to send password reset email. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')), // AppBar with title
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Form(
          key: _formKey, // Assign the key to the Form widget for validation
          child: Column(
            children: [
              // Display error message if there is one
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red), // Error message in red
                  ),
                ),
              // Email input field with validation
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress, // Keyboard type for email
                validator: (value) {
                  // Validate email input
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'; // Required field
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address'; // Email format validation
                  }
                  return null; // Valid input
                },
              ),
              // Password input field with validation
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // Hide password input
                validator: (value) {
                  // Validate password input
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'; // Required field
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long'; // Minimum length
                  }
                  return null; // Valid input
                },
              ),
              const SizedBox(height: 20), // Space between fields and button
              ElevatedButton(
                onPressed: _login, // Call the login function when pressed
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: _resetPassword, // Call the reset password function when pressed
                child: const Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to Sign Up Page
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}