# Student Registration System

The Student Registration System is a Flutter application that allows students to register for courses, view their personal information, and manage their profile settings.

## Features

- Registration for courses
- Viewing course details
- Editing personal information
- Changing password
- Displaying grades (future feature)

## Prerequisites

- Flutter SDK installed
- Android Studio or Xcode (for building and running on Android or iOS devices)
- Firebase account and project set up

## Setup

1. Clone the repository:
   git clone https://github.com/BenJie258/student-registration-system.git

2. Navigate to the project directory:
   cd student-registration-system

3. Install dependencies:
   flutter pub get

## Set up Firebase:
1. Create a Firebase project in the Firebase Console.
2. Enable Email/Password authentication in the Firebase Authentication section.
3. Create a Firestore database and configure the security rules.
4. Download the google-services.json file for Android or GoogleService-Info.plist for iOS and place it in the respective platform-specific directories.
5. Run the app:
   flutter run

## Usage
1. Registration: Click on the "Registration" link on the home page to navigate to the registration form. Fill in the required details and click "Register" to complete the registration process.

2. Course Details: Click on a course card to view the course details, including the description, syllabus, and lecturer information. Click "Register Now" to navigate to the registration page for that specific course.

3. Profile Management: Click on the profile icon in the top-right corner of the app to access the profile page. Here, you can edit your personal information, change your password, and view your grades (future feature).

## Troubleshooting
If you encounter any issues while setting up or running the app, please refer to the following resources:
Flutter documentation: https://flutter.dev/docs
Firebase documentation: https://firebase.google.com/docs
Stack Overflow: https://stackoverflow.com

For common issues and troubleshooting tips, please refer to the [Documentation](Documentation.md).

## License
This project is licensed under the MIT License.

