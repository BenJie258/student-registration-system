import 'package:flutter/material.dart';
import 'package:studentreg_system/screens/registration.dart'; // Import the RegistrationPage

class CourseCard extends StatelessWidget {
  final String courseTitle;
  final String lecturerName;

  const CourseCard({
    super.key,
    required this.courseTitle,
    required this.lecturerName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(courseTitle),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Description: This course covers the fundamentals of programming.'),
                  const Text('Syllabus: Topics include variables, loops, functions, and basic data structures.'),
                  Text('Lecturer: $lecturerName'),
                  ElevatedButton(
                    child: const Text('Register Now'),
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close the dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationPage()),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(courseTitle),
          subtitle: Text(lecturerName),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}