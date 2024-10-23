import 'package:flutter/material.dart';

class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  final TextEditingController _midtermController = TextEditingController();
  final TextEditingController _finalController = TextEditingController();
  String _average = '';

  void _calculateAverage() {
    double midterm = double.tryParse(_midtermController.text) ?? 0;
    double finalScore = double.tryParse(_finalController.text) ?? 0;
    setState(() {
      double average = (midterm * 0.4) + (finalScore * 0.6);
      _average = 'Average: ${average.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professor Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _midtermController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Midterm Grade'),
            ),
            TextField(
              controller: _finalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Final Grade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAverage,
              child: Text('Calculate Average'),
            ),
            SizedBox(height: 20),
            Text(_average),
          ],
        ),
      ),
    );
  }
}
