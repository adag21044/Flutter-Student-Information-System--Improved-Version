import 'package:flutter/material.dart';

// ProfessorPage allows a professor to view and update student grades
class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  // List of students with initial grades
  List<Map<String, dynamic>> students = [
    {'name': 'Joe', 'midterm': 0.0, 'final': 0.0} // Initial student data
  ];

  // Method to update the grades of a student at a specific index
  void _updateGrades(int index, double midterm, double finalScore) {
    setState(() {
      // Update midterm and final scores for the student
      students[index]['midterm'] = midterm;
      students[index]['final'] = finalScore;
    });
  }

  // Method to calculate the average score based on midterm and final scores
  double _calculateAverage(double midterm, double finalScore) => (midterm * 0.4 + finalScore * 0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Professor Page')), // Title for the page
      body: ListView.builder(
        itemCount: students.length, // Number of students
        itemBuilder: (context, index) {
          var student = students[index]; // Get the student data at current index
          return ListTile(
            title: Text(student['name']), // Display student's name
            subtitle: Text('Average: ${_calculateAverage(student['midterm'], student['final']).toStringAsFixed(2)}'), // Display calculated average
            onTap: () => _showGradeDialog(context, index), // Open grade update dialog on tap
          );
        },
      ),
    );
  }

  // Dialog to update grades for a selected student
  void _showGradeDialog(BuildContext context, int index) {
    final TextEditingController midtermController = TextEditingController(); // Controller for midterm input
    final TextEditingController finalController = TextEditingController(); // Controller for final input

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Grades'), // Title for the dialog
        content: Column(
          mainAxisSize: MainAxisSize.min, // Minimize dialog height
          children: [
            // TextField to input midterm score
            TextField(
              controller: midtermController, // Controller for midterm
              decoration: InputDecoration(labelText: 'Midterm'), // Label for the TextField
              keyboardType: TextInputType.number, // Numeric keyboard
            ),
            // TextField to input final score
            TextField(
              controller: finalController, // Controller for final
              decoration: InputDecoration(labelText: 'Final'), // Label for the TextField
              keyboardType: TextInputType.number, // Numeric keyboard
            ),
          ],
        ),
        actions: [
          // Save button to update grades
          TextButton(
            onPressed: () {
              // Parse input text as doubles, defaulting to 0.0 if parsing fails
              double midterm = double.tryParse(midtermController.text) ?? 0.0;
              double finalScore = double.tryParse(finalController.text) ?? 0.0;
              _updateGrades(index, midterm, finalScore); // Update grades for student
              Navigator.pop(context); // Close dialog
            },
            child: Text('Save'), // Button label
          ),
        ],
      ),
    );
  }
}
