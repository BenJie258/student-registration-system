import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCoursesPage extends StatelessWidget {
  MyCoursesPage({super.key});

  // Mapping of course titles to lecturer names
  final Map<String, String> courseLecturerMap = {
    'Introduction to Programming': 'Dr. John Doe',
    'Data Structures': 'Prof. Jane Smith',
    'Algorithms': 'Mr. Alex Johnson',
    'Web Development': 'Ms. Emily Taylor',
    'Mobile App Development': 'Dr. Sarah Connor',
    'Machine Learning': 'Prof. Bruce Wayne',
    'Database Systems': 'Mr. Peter Parker',
    'Software Engineering': 'Ms. Diana Prince',
    'Web Design': 'Dr. Tony Stark',
    'Cybersecurity': 'Prof. Natasha Romanoff',
    'Cloud Computing': 'Mr. Clark Kent',
    'Artificial Intelligence': 'Ms. Carol Danvers',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('registration').snapshots(),
        builder: (context, snapshot) {
          // Check if the connection is still waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check if there is no data or the documents are empty
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No courses registered.'));
          }

          final courses = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              childAspectRatio: 1.5, // Aspect ratio for each item
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final courseData = courses[index];
              final courseName = courseData['Course'] ?? 'Unknown Course';

              // Get the lecturer's name from the mapping
              final lecturerName =
                  courseLecturerMap[courseName] ?? 'Unknown Lecturer';

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(courseName),
                      const SizedBox(height: 8),
                      Text(
                          'Instructor: $lecturerName'), // Display the lecturer's name
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
