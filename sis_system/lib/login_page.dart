import 'package:flutter/material.dart';

// Login Page to authenticate and navigate users based on role
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers to capture user input for username and password
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Student'; // Default role is set to "Student"

  // Predefined user credentials for different roles
  final Map<String, String> _validUsers = {
    'student': 'student123',
    'professor': 'professor123',
    'secretary': 'secretary123',
  };

  // Login function to check credentials and navigate to the appropriate page
  void _login(BuildContext context) {
    // Validate the selected role with the entered password
    if (_validUsers[_selectedRole.toLowerCase()] == _passwordController.text) {
      // Navigate based on the selected role
      if (_selectedRole == 'Student') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentPage()),
        );
      } else if (_selectedRole == 'Professor') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfessorPage()),
        );
      } else if (_selectedRole == 'Secretary') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecretaryPage()),
        );
      }
    } else {
      // Show error message if credentials are invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')), // Title for the AppBar
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          children: [
            // TextField for entering the username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            // TextField for entering the password, obscured for privacy
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10), // Spacing between TextField and RadioButton

            // RadioButton group for role selection (Student, Professor, Secretary)
            Column(
              children: ['Student', 'Professor', 'Secretary'].map((role) {
                return RadioListTile<String>(
                  title: Text(role), // Display role as label
                  value: role, // Role value
                  groupValue: _selectedRole, // Current selected role
                  onChanged: (String? newRole) {
                    setState(() {
                      _selectedRole = newRole!; // Update selected role
                    });
                  },
                );
              }).toList(),
            ),

            // Login button to trigger the _login function
            ElevatedButton(
              onPressed: () => _login(context), // Calls _login function
              child: Text('Login'), // Button label
            ),
          ],
        ),
      ),
    );
  }
}

// Secretary Page for managing students and announcements
class SecretaryPage extends StatefulWidget {
  @override
  _SecretaryPageState createState() => _SecretaryPageState();
}

class _SecretaryPageState extends State<SecretaryPage> {
  List<String> students = []; // List of students
  List<String> announcements = []; // List of announcements
  final TextEditingController _studentController = TextEditingController(); // Controller for student input
  final TextEditingController _announcementController = TextEditingController(); // Controller for announcement input

  // Adds a new student to the list
  void _addStudent() {
    setState(() {
      students.add(_studentController.text); // Add student name to list
      _studentController.clear(); // Clear input field
    });
  }

  // Removes a student from the list
  void _removeStudent(String student) {
    setState(() {
      students.remove(student); // Remove selected student from list
    });
  }

  // Adds a new announcement to the list
  void _addAnnouncement() {
    setState(() {
      announcements.add(_announcementController.text); // Add announcement to list
      _announcementController.clear(); // Clear input field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Secretary Page')), // AppBar with page title
      body: Column(
        children: [
          // TextField and button for adding students
          TextField(controller: _studentController, decoration: InputDecoration(labelText: 'Add Student Name')),
          ElevatedButton(onPressed: _addStudent, child: Text('Add Student')),
          Expanded(
            child: ListView.builder(
              itemCount: students.length, // Number of students in the list
              itemBuilder: (context, index) => ListTile(
                title: Text(students[index]), // Display student name
                trailing: IconButton(
                  icon: Icon(Icons.delete), // Delete icon
                  onPressed: () => _removeStudent(students[index]), // Remove student on click
                ),
              ),
            ),
          ),
          // TextField and button for adding announcements
          TextField(controller: _announcementController, decoration: InputDecoration(labelText: 'Add Announcement')),
          ElevatedButton(onPressed: _addAnnouncement, child: Text('Add Announcement')),
          Expanded(
            child: ListView.builder(
              itemCount: announcements.length, // Number of announcements
              itemBuilder: (context, index) => ListTile(title: Text(announcements[index])), // Display announcement
            ),
          ),
        ],
      ),
    );
  }
}

// Professor Page for updating student grades
class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  List<Map<String, dynamic>> students = [
    {'name': 'Ali', 'midterm': 0.0, 'final': 0.0}
  ];

  // Updates student grades
  void _updateGrades(int index, double midterm, double finalScore) {
    setState(() {
      students[index]['midterm'] = midterm; // Update midterm score
      students[index]['final'] = finalScore; // Update final score
    });
  }

  // Calculates average score based on midterm and final grades
  double _calculateAverage(double midterm, double finalScore) => (midterm * 0.4 + finalScore * 0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Professor Page')), // AppBar with page title
      body: ListView.builder(
        itemCount: students.length, // Number of students
        itemBuilder: (context, index) {
          var student = students[index];
          return ListTile(
            title: Text(student['name']), // Display student name
            subtitle: Text('Average: ${_calculateAverage(student['midterm'], student['final']).toStringAsFixed(2)}'), // Display calculated average
            onTap: () => _showGradeDialog(context, index), // Opens grade dialog on tap
          );
        },
      ),
    );
  }

  // Dialog to enter or update grades
  void _showGradeDialog(BuildContext context, int index) {
    final TextEditingController midtermController = TextEditingController();
    final TextEditingController finalController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Grades'), // Dialog title
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for entering midterm score
            TextField(controller: midtermController, decoration: InputDecoration(labelText: 'Midterm'), keyboardType: TextInputType.number),
            // TextField for entering final score
            TextField(controller: finalController, decoration: InputDecoration(labelText: 'Final'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          // Save button to update grades
          TextButton(
            onPressed: () {
              double midterm = double.tryParse(midtermController.text) ?? 0.0; // Parse midterm score
              double finalScore = double.tryParse(finalController.text) ?? 0.0; // Parse final score
              _updateGrades(index, midterm, finalScore); // Update grades
              Navigator.pop(context); // Close dialog
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

// Student Page for managing a to-do list
class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<String> todoList = []; // List of tasks for the student
  final TextEditingController _todoController = TextEditingController(); // Controller for task input

  // Adds a new task to the list
  void _addTodo() {
    setState(() {
      todoList.add(_todoController.text); // Add task to list
      _todoController.clear(); // Clear input field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Page')), // AppBar with page title
      body: Column(
        children: [
          // TextField and button for adding a task
          TextField(controller: _todoController, decoration: InputDecoration(labelText: 'Enter Task')),
          ElevatedButton(onPressed: _addTodo, child: Text('Add Task')),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length, // Number of tasks
              itemBuilder: (context, index) => ListTile(title: Text(todoList[index])), // Display task
            ),
          ),
        ],
      ),
    );
  }
}
