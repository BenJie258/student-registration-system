import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentreg_system/screens/mycourses.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _enrollmentDate; // Store the selected date
  String? _selectedGender;
  String? _selectedCourse;

  final List<String> _courses = [
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
    'Artificial Intelligence',
    'Computer Networks',
    'Operating Systems',
    'Computer Architecture',
    'Discrete Mathematics',
    'Calculus',
    'Linear Algebra',
    'Probability and Statistics',
    'Cryptography',
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: _genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: const InputDecoration(labelText: 'Course'),
                items: _courses.map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCourse = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a course';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Enrollment Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _enrollmentDate = selectedDate; // Set the selected date
                    });
                  }
                },
                validator: (value) {
                  if (_enrollmentDate == null) {
                    return 'Please select your enrollment date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Store the current context in a local variable
                    final currentContext = context;

                    // Save user data to Firestore
                    await FirebaseFirestore.instance.collection('users').add({
                      'first_name': _firstNameController.text,
                      'last_name': _lastNameController.text,
                      'gender': _selectedGender,
                      'course': _selectedCourse,
                      'phone': _phoneController.text,
                      'enrollment_date': _enrollmentDate != null
                          ? Timestamp.fromDate(_enrollmentDate!) // Convert to Timestamp
                          : null,
                    });

                    // Show success message
                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      const SnackBar(content: Text('Registration successful!')),
                    );

                    // Navigate to My Courses page
                    Navigator.pushReplacement(
                      currentContext,
                      MaterialPageRoute(builder: (context) => MyCoursesPage()),
                    );
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}