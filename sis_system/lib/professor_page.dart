import 'package:flutter/material.dart';
import 'data_manager.dart';
import 'models/student.dart';

class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    List<Student> loadedStudents = await DataManager.loadStudents();
    setState(() {
      students = loadedStudents;
    });
  }

  void _updateStudentGrade(Student student, double midterm, double finalScore) {
    setState(() {
      student.midterm = midterm;
      student.finalScore = finalScore;
      DataManager.saveStudents(students);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professor Page'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          Student student = students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text(
                'Midterm: ${student.midterm}, Final: ${student.finalScore}, Average: ${student.calculateAverage()}'),
            onTap: () => _showGradeDialog(context, student),
          );
        },
      ),
    );
  }

  void _showGradeDialog(BuildContext context, Student student) {
    final _midtermController = TextEditingController(text: student.midterm.toString());
    final _finalController = TextEditingController(text: student.finalScore.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Grades for ${student.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _midtermController,
                decoration: InputDecoration(labelText: 'Midterm Grade'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _finalController,
                decoration: InputDecoration(labelText: 'Final Grade'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () {
                double midterm = double.tryParse(_midtermController.text) ?? 0;
                double finalScore = double.tryParse(_finalController.text) ?? 0;
                _updateStudentGrade(student, midterm, finalScore);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
