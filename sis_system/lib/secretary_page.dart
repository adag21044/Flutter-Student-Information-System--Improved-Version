import 'package:flutter/material.dart';
import 'data_manager.dart';
import 'models/student.dart';
import 'models/professor.dart';

class SecretaryPage extends StatefulWidget {
  @override
  _SecretaryPageState createState() => _SecretaryPageState();
}

class _SecretaryPageState extends State<SecretaryPage> {
  List<Student> students = [];
  List<Professor> professors = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<Student> loadedStudents = await DataManager.loadStudents();
    List<Professor> loadedProfessors = await DataManager.loadProfessors();
    setState(() {
      students = loadedStudents;
      professors = loadedProfessors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secretary Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text('Professors:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...professors.map((prof) => ListTile(title: Text(prof.name))),
                  SizedBox(height: 20),
                  Text('Students and Grades:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...students.map((student) {
                    return ListTile(
                      title: Text(student.name),
                      subtitle: Text(
                          'Midterm: ${student.midterm}, Final: ${student.finalScore}, Average: ${student.calculateAverage()}'),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
