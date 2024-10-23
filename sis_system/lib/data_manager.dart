import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/student.dart';
import 'models/professor.dart';

class DataManager {
  static const String _studentKey = 'students';
  static const String _professorKey = 'professors';

  // Öğrencileri kaydetmek için
  static Future<void> saveStudents(List<Student> students) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> studentJsonList = students.map((student) => jsonEncode(student.toMap())).toList();
    await prefs.setStringList(_studentKey, studentJsonList);
  }

  // Öğrencileri yüklemek için
  static Future<List<Student>> loadStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? studentJsonList = prefs.getStringList(_studentKey);
    if (studentJsonList != null) {
      return studentJsonList.map((jsonString) => Student.fromMap(jsonDecode(jsonString))).toList();
    }
    return [];
  }

  // Hocaları kaydetmek için
  static Future<void> saveProfessors(List<Professor> professors) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> professorJsonList = professors.map((prof) => jsonEncode(prof.toMap())).toList();
    await prefs.setStringList(_professorKey, professorJsonList);
  }

  // Hocaları yüklemek için
  static Future<List<Professor>> loadProfessors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? professorJsonList = prefs.getStringList(_professorKey);
    if (professorJsonList != null) {
      return professorJsonList.map((jsonString) => Professor.fromMap(jsonDecode(jsonString))).toList();
    }
    return [];
  }
}
