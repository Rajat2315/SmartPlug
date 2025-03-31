import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RetrieveDataScreen extends StatefulWidget {
  @override
  _RetrieveDataScreenState createState() => _RetrieveDataScreenState();
}

class _RetrieveDataScreenState extends State<RetrieveDataScreen> {
  final TextEditingController deviceIdController = TextEditingController();
  List<Map<String, dynamic>> logs = [];
  double averagePowerConsumption = 0.0;
  bool isLoading = false;
  bool deviceExists = true;

  Future<void> fetchLogs() async {
    setState(() {
      isLoading = true;
      logs = [];
      deviceExists = true;
      averagePowerConsumption = 0.0;
    });

    String userId = "user123"; // Replace with actual logged-in user ID
    String deviceId = deviceIdController.text.trim();

    if (deviceId.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter a Device ID')));
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      // Reference to logs under the given device
      QuerySnapshot logsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('devices')
          .doc(deviceId)
          .collection('logs')
          .orderBy('timestamp', descending: true)
          .get();

      if (logsSnapshot.docs.isNotEmpty) {
        logs = logsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        // Calculate average power consumption
        double totalPower = 0;
        int count = 0;

        for (var log in logs) {
          if (log['power_consumption'] != null) {
            totalPower += (log['power_consumption'] as num).toDouble();
            count++;
          }
        }

        setState(() {
          averagePowerConsumption = count > 0 ? totalPower / count : 0.0;
          isLoading = false;
        });
      } else {
        setState(() {
          deviceExists = false;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No logs found for this device')));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error retrieving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrieve Device Logs')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: deviceIdController,
              decoration: InputDecoration(labelText: 'Enter Device ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: fetchLogs, child: Text('Retrieve Logs')),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : deviceExists
                    ? Expanded(
                        child: logs.isNotEmpty
                            ? Column(
                                children: [
                                  Text(
                                    'Average Power Consumption: ${averagePowerConsumption.toStringAsFixed(2)} W',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: logs.length,
                                      itemBuilder: (context, index) {
                                        final log = logs[index];
                                        bool isAboveAverage =
                                            (log['power_consumption'] ?? 0) >
                                                averagePowerConsumption;
                                        bool isOn = log['status'] == "On";

                                        return Card(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: (isAboveAverage && isOn)
                                              ? Colors.redAccent
                                                  .withOpacity(0.3)
                                              : Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              'Power: ${log['power_consumption']} W',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Status: ${log['status']}'),
                                                Text('Time: ${log['time']}'),
                                              ],
                                            ),
                                            trailing: Text(
                                              log['timestamp'] != null
                                                  ? (log['timestamp']
                                                          as Timestamp)
                                                      .toDate()
                                                      .toString()
                                                  : 'No Timestamp',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Text('No logs found',
                                style: TextStyle(fontSize: 16)),
                      )
                    : Text('Device not found',
                        style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
