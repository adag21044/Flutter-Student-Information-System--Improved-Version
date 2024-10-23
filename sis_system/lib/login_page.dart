import 'package:flutter/material.dart';
import 'secretary_page.dart';
import 'professor_page.dart';
import 'student_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: <String>['Student', 'Professor', 'Secretary']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (_selectedRole == 'Student') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentPage()),
      );
    } else if (_selectedRole == 'Professor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfessorPage()),
      );
    } else if (_selectedRole == 'Secretary') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecretaryPage()),
      );
    }
  }
}
