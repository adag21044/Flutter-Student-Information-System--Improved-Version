import 'package:flutter/material.dart';
import 'data_manager.dart';
import 'models/student.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final TextEditingController _todoController = TextEditingController();
  List<String> todoList = [];

  void _addTodoItem() {
    setState(() {
      todoList.add(_todoController.text);
      _todoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(labelText: 'Enter Task'),
          ),
          ElevatedButton(
            onPressed: _addTodoItem,
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todoList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
