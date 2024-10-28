import 'package:flutter/material.dart';
import 'secretary_page.dart';
import 'professor_page.dart';
import 'student_page.dart';

// Entry point of the application
void main() {
  runApp(MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information System', // Title of the application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color scheme to blue
      ),
      home: LoginPage(), // Sets the home screen as LoginPage
    );
  }
}

// LoginPage widget to authenticate users and navigate based on role
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for capturing user input in the username and password fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'Student'; // Default role selection
  String _errorMessage = ''; // Variable to hold error message for invalid credentials

  // Map to store predefined user credentials for each role
  final Map<String, String> _validUsers = {
    'student': 'student123',
    'professor': 'professor123',
    'secretary': 'secretary123',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'), // Title displayed on the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding around the form
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField for entering the username
            TextField(
              controller: _usernameController, // Controller for username input
              decoration: InputDecoration(labelText: 'Username'), // Label for TextField
            ),
            // TextField for entering the password
            TextField(
              controller: _passwordController, // Controller for password input
              decoration: InputDecoration(labelText: 'Password'), // Label for TextField
              obscureText: true, // Hides the password input
            ),
            SizedBox(height: 20), // Spacing between fields and dropdown

            // DropdownButton for selecting the role (Student, Professor, Secretary)
            DropdownButton<String>(
              value: _selectedRole, // Current selected role
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!; // Update selected role
                });
              },
              items: <String>['Student', 'Professor', 'Secretary'] // Dropdown options
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value), // Display role option
                );
              }).toList(),
            ),
            SizedBox(height: 20), // Spacing before login button

            // ElevatedButton to trigger the login function
            ElevatedButton(
              onPressed: () {
                _login(context); // Calls _login function when pressed
              },
              child: Text('Login'), // Button label
            ),
            
            // Displays an error message if login fails
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage, // Error message text
                  style: TextStyle(color: Colors.red), // Red color for error
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to validate credentials and navigate based on role
  void _login(BuildContext context) {
    String username = _usernameController.text; // Gets username input
    String password = _passwordController.text; // Gets password input

    // Check if the role exists in _validUsers and password matches
    if (_validUsers.containsKey(_selectedRole.toLowerCase()) &&
        _validUsers[_selectedRole.toLowerCase()] == password) {
      setState(() {
        _errorMessage = ''; // Clear any previous error message
      });

      // Navigate based on the selected role
      if (_selectedRole == 'Student') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentPage()), // Navigate to StudentPage
        );
      } else if (_selectedRole == 'Professor') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfessorPage()), // Navigate to ProfessorPage
        );
      } else if (_selectedRole == 'Secretary') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecretaryPage()), // Navigate to SecretaryPage
        );
      }
    } else {
      // If credentials are invalid, set an error message
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }
}
