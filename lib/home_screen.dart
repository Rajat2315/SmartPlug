import 'package:flutter/material.dart';
import 'add_entry.dart';
import 'retrieve_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Device Manager')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEntryScreen()));
              },
              child: Text('Add Entry'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RetrieveDataScreen()));
              },
              child: Text('Retrieve Data'),
            ),
          ],
        ),
      ),
    );
  }
}
