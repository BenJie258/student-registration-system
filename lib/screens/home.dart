import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentreg_system/Widgets/coursecard.dart'; // Import the CourseCard widget
import 'grades.dart'; // Import the GradesPage
import 'registration.dart'; // Import the RegistrationPage
import 'mycourses.dart'; // Import the MyCoursesPage
import 'profile.dart'; // Import the ProfilePage
import 'login.dart'; // Import the LoginPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
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
    // Initialize Firebase for iOS similarly if needed
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}

// This widget checks the user's authentication state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while waiting for authentication status
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // If the user is authenticated, show the home page
          return const HomePage();
        } else {
          // If the user is not authenticated, show the login page
          return const LoginPage();
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'), // Ensure you have a logo.png in assets
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => showMenu(
              context: context,
              position: const RelativeRect.fromLTRB(100, 50, 0, 0), // Adjust as needed
              items: [
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Grades'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GradesPage()),
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatelessWidget {
  HomePageBody({super.key});

  // Define the lists of course titles and lecturers
  final List<String> courseTitles = [
    'Introduction to Programming',
    'Data Structures',
    'Algorithms',
    'Web Development',
    'Mobile App Development',
    'Machine Learning',
    'Database Systems',
    'Software Engineering',
    'Web Design',
    'Cybersecurity',
    'Cloud Computing',
    'Artificial Intelligence'
  ];

  final List<String> lecturers = [
    'Dr. John Doe',
    'Prof. Jane Smith',
    'Mr. Alex Johnson',
    'Ms. Emily Taylor',
    'Dr. Sarah Connor',
    'Prof. Bruce Wayne',
    'Mr. Peter Parker',
    'Ms. Diana Prince',
    'Dr. Tony Stark',
    'Prof. Natasha Romanoff',
    'Mr. Clark Kent',
    'Ms. Carol Danvers'
  ];

  // Build a single CourseCard widget
  Widget _buildCourseCard(int index) {
    String courseTitle = courseTitles[index];
    String lecturerName = lecturers[index];

    // Use the CourseCard widget here
    return CourseCard(courseTitle: courseTitle, lecturerName: lecturerName);
  }

  Widget _buildNavigationLink(String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'My Courses') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCoursesPage()),
          );
        } else if (label == 'Registration') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrationPage()),
          );
        }
        // Add more navigation logic here if needed
      },
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildNavigationLink('Home', context),
              _buildNavigationLink('My Courses', context),
              _buildNavigationLink('Registration', context),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: courseTitles.length, // Number of courses
            itemBuilder: (context, index) {
              return _buildCourseCard(index); // Build each CourseCard
            },
          ),
        ),
      ],
    );
  }
}