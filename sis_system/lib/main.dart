import 'package:flutter/material.dart';
import 'secretary_page.dart';
import 'professor_page.dart';
import 'student_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Student';
  String _errorMessage = '';

  final Map<String, String> _validUsers = {
    'student': 'student123',
    'professor': 'professor123',
    'secretary': 'secretary123',
  };

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
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (_validUsers.containsKey(_selectedRole.toLowerCase()) &&
        _validUsers[_selectedRole.toLowerCase()] == password) {
      setState(() {
        _errorMessage = '';
      });

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
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }
}
