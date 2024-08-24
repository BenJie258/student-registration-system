import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:logger/logger.dart'; // Import the logger package
import 'screens/home.dart';
import 'screens/login.dart'; // Import the Login Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create a logger instance
  final logger = Logger();

  // Initialize Firebase
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCfh7dW4QZnyadQFMQ2QLhs-ZKmU8p6NKw",
          appId: "1:329272704175:android:8b6d66e4114c73a78b685a",
          messagingSenderId: "329272704175",
          projectId: "stu-regsystem",
        ),
      );
    } else if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCfh7dW4QZnyadQFMQ2QLhs-ZKmU8p6NKw",
          appId: "1:329272704175:ios:8b6d66e4114c73a78b685a",
          messagingSenderId: "329272704175",
          projectId: "stu-regsystem",
        ),
      );
    }
  } catch (e) {
    logger.e("Error initializing Firebase: $e"); // Use logger instead of print
  }

  // Check the user's authentication state
  User? currentUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp(initialRoute: currentUser != null ? const HomePage() : const LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration System',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue, // Use colorSchemeSeed for Material 3 color theming
        scaffoldBackgroundColor: Colors.blue, // Setting a specific background color if needed
        appBarTheme: const 
        AppBarTheme(color: Colors.blue,),
      ),
      home: initialRoute, // Set the initial route based on authentication state
    );
  }
}