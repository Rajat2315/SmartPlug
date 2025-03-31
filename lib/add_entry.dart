import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final TextEditingController deviceIdController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  String status = 'On';
  TimeOfDay? lastUpdate;

  Future<void> addLogEntry() async {
    String userId = "user123"; // Replace with actual logged-in user ID
    String deviceId = deviceIdController.text.trim(); // Get device ID input

    if (deviceId.isEmpty ||
        powerController.text.isEmpty ||
        lastUpdate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    double? power = double.tryParse(powerController.text);
    if (power == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid power consumption value')),
      );
      return;
    }

    try {
      // Reference to logs subcollection under specific device
      CollectionReference logsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('devices')
          .doc(deviceId)
          .collection('logs');

      // Add new log entry
      await logsRef.add({
        'power_consumption': power,
        'status': status,
        'time': '${lastUpdate!.hour}:${lastUpdate!.minute}',
        'timestamp': FieldValue.serverTimestamp(), // Auto timestamp
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log entry added successfully ✅'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear input fields
      deviceIdController.clear();
      powerController.clear();
      setState(() {
        lastUpdate = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding log: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Log Entry')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: deviceIdController,
              decoration: InputDecoration(labelText: 'Device ID'),
            ),
            TextField(
              controller: powerController,
              decoration: InputDecoration(labelText: 'Power Consumption (W)'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: status,
              onChanged: (String? newValue) {
                setState(() {
                  status = newValue!;
                });
              },
              items: ['On', 'Off'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? picked = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (picked != null) setState(() => lastUpdate = picked);
              },
              child: Text(lastUpdate == null
                  ? 'Pick Time'
                  : 'Time: ${lastUpdate!.format(context)}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addLogEntry,
              child: Text('Submit Log'),
            ),
          ],
        ),
      ),
    );
  }
}
