import 'package:flutter/material.dart';

// SecretaryPage allows a secretary to manage students and announcements
class SecretaryPage extends StatefulWidget {
  @override
  _SecretaryPageState createState() => _SecretaryPageState();
}

class _SecretaryPageState extends State<SecretaryPage> {
  // List to store the names of students
  List<String> students = [];
  
  // List to store announcements
  List<String> announcements = [];

  // Controllers to capture input for adding a student and an announcement
  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _announcementController = TextEditingController();

  // Method to add a new student to the students list
  void _addStudent() {
    setState(() {
      students.add(_studentController.text); // Add the text from _studentController to students list
      _studentController.clear(); // Clear the input field after adding
    });
  }

  // Method to remove a student from the students list
  void _removeStudent(String student) {
    setState(() {
      students.remove(student); // Remove the specified student from the list
    });
  }

  // Method to add a new announcement to the announcements list
  void _addAnnouncement() {
    setState(() {
      announcements.add(_announcementController.text); // Add the text from _announcementController to announcements list
      _announcementController.clear(); // Clear the input field after adding
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Secretary Page')), // Title for the AppBar
      body: Column(
        children: [
          // TextField and button for adding students
          TextField(
            controller: _studentController, // Controller for student input
            decoration: InputDecoration(labelText: 'Add Student Name'), // Label for TextField
          ),
          ElevatedButton(
            onPressed: _addStudent, // Calls _addStudent to add student to list
            child: Text('Add Student'), // Button label
          ),
          
          // ListView to display the list of students
          Expanded(
            child: ListView.builder(
              itemCount: students.length, // Number of students
              itemBuilder: (context, index) => ListTile(
                title: Text(students[index]), // Display student name
                trailing: IconButton(
                  icon: Icon(Icons.delete), // Delete icon button
                  onPressed: () => _removeStudent(students[index]), // Calls _removeStudent to remove the student
                ),
              ),
            ),
          ),
          
          // TextField and button for adding announcements
          TextField(
            controller: _announcementController, // Controller for announcement input
            decoration: InputDecoration(labelText: 'Add Announcement'), // Label for TextField
          ),
          ElevatedButton(
            onPressed: _addAnnouncement, // Calls _addAnnouncement to add announcement to list
            child: Text('Add Announcement'), // Button label
          ),
          
          // ListView to display the list of announcements
          Expanded(
            child: ListView.builder(
              itemCount: announcements.length, // Number of announcements
              itemBuilder: (context, index) => ListTile(
                title: Text(announcements[index]), // Display announcement
              ),
            ),
          ),
        ],
      ),
    );
  }
}
