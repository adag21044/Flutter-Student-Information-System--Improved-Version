import 'package:flutter/material.dart';

// StudentPage allows a student to manage their to-do list
class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  // List to store to-do tasks
  List<String> todoList = [];
  
  // Controller to capture input for new to-do tasks
  final TextEditingController _todoController = TextEditingController();

  // Method to add a new task to the to-do list
  void _addTodo() {
    setState(() {
      todoList.add(_todoController.text); // Add the text from _todoController to the todoList
      _todoController.clear(); // Clear the input field after adding
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Page')), // Title for the AppBar
      body: Column(
        children: [
          // TextField for entering a new task
          TextField(
            controller: _todoController, // Controller for to-do input
            decoration: InputDecoration(labelText: 'Enter Task'), // Label for TextField
          ),
          
          // Button to add the entered task to the to-do list
          ElevatedButton(
            onPressed: _addTodo, // Calls _addTodo to add task to list
            child: Text('Add Task'), // Button label
          ),
          
          // ListView to display the list of to-do tasks
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length, // Number of tasks in the list
              itemBuilder: (context, index) => ListTile(
                title: Text(todoList[index]), // Display the task
              ),
            ),
          ),
        ],
      ),
    );
  }
}
