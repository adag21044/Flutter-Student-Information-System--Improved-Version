import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/student.dart';
import 'models/professor.dart';

// DataManager class to manage saving and loading of student and professor data
class DataManager {
  // Keys to store lists of students and professors in SharedPreferences
  static const String _studentKey = 'students';
  static const String _professorKey = 'professors';

  // Method to save a list of students in SharedPreferences
  static Future<void> saveStudents(List<Student> students) async {
    // Access SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Convert each Student instance to a JSON string and store them in a list
    List<String> studentJsonList = students.map((student) => jsonEncode(student.toMap())).toList();
    
    // Save the list of JSON strings under the key '_studentKey'
    await prefs.setStringList(_studentKey, studentJsonList);
  }

  // Method to load a list of students from SharedPreferences
  static Future<List<Student>> loadStudents() async {
    // Access SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Retrieve the list of student JSON strings using '_studentKey'
    List<String>? studentJsonList = prefs.getStringList(_studentKey);
    
    // If student data exists, convert each JSON string back into a Student instance
    if (studentJsonList != null) {
      return studentJsonList.map((jsonString) => Student.fromMap(jsonDecode(jsonString))).toList();
    }
    
    // Return an empty list if no data is found
    return [];
  }

  // Method to save a list of professors in SharedPreferences
  static Future<void> saveProfessors(List<Professor> professors) async {
    // Access SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Convert each Professor instance to a JSON string and store them in a list
    List<String> professorJsonList = professors.map((prof) => jsonEncode(prof.toMap())).toList();
    
    // Save the list of JSON strings under the key '_professorKey'
    await prefs.setStringList(_professorKey, professorJsonList);
  }

  // Method to load a list of professors from SharedPreferences
  static Future<List<Professor>> loadProfessors() async {
    // Access SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Retrieve the list of professor JSON strings using '_professorKey'
    List<String>? professorJsonList = prefs.getStringList(_professorKey);
    
    // If professor data exists, convert each JSON string back into a Professor instance
    if (professorJsonList != null) {
      return professorJsonList.map((jsonString) => Professor.fromMap(jsonDecode(jsonString))).toList();
    }
    
    // Return an empty list if no data is found
    return [];
  }
}
