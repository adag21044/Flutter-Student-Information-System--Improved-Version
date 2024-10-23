import 'package:flutter/material.dart';
import 'data_manager.dart';
import 'models/student.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          Student student = students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text(
                'Midterm: ${student.midterm}, Final: ${student.finalScore}, Average: ${student.calculateAverage()}'),
          );
        },
      ),
    );
  }
}
