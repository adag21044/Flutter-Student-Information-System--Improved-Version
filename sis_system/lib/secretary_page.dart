import 'package:flutter/material.dart';

class SecretaryPage extends StatefulWidget {
  @override
  _SecretaryPageState createState() => _SecretaryPageState();
}

class _SecretaryPageState extends State<SecretaryPage> {
  List<String> announcements = [];
  final TextEditingController _announcementController = TextEditingController();

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
              controller: _announcementController,
              decoration: InputDecoration(labelText: 'Enter Announcement'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_announcementController.text.isNotEmpty) {
                    announcements.add(_announcementController.text);
                    _announcementController.clear();
                  }
                });
              },
              child: Text('Add Announcement'),
            ),
            SizedBox(height: 20),
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
