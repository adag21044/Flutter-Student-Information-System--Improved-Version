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
  List<String> announcements = [];
  final TextEditingController _announcementController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();

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

  void _addStudent() {
    setState(() {
      students.add(Student(name: _studentController.text));
      DataManager.saveStudents(students);
      _studentController.clear();
    });
  }

  void _removeStudent(Student student) {
    setState(() {
      students.remove(student);
      DataManager.saveStudents(students);
    });
  }

  void _addAnnouncement() {
    setState(() {
      announcements.add(_announcementController.text);
      _announcementController.clear();
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
            TextField(
              controller: _studentController,
              decoration: InputDecoration(labelText: 'Enter Student Name'),
            ),
            ElevatedButton(
              onPressed: _addStudent,
              child: Text('Add Student'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(students[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeStudent(students[index]),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _announcementController,
              decoration: InputDecoration(labelText: 'Enter Announcement'),
            ),
            ElevatedButton(
              onPressed: _addAnnouncement,
              child: Text('Add Announcement'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(announcements[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
