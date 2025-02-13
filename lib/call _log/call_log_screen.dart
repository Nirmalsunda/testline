// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/colors.dart';
import 'call_log_provider.dart';

class CallLogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the CallLogProvider directly using Provider.of
    var callLogProvider = Provider.of<CallLogProvider>(context);
    var callLogs = callLogProvider.callLogs;

    return Scaffold(
      appBar: AppBar(title: Text("Call Logs"), backgroundColor: tlprimarycolor),
      body: callLogs.isEmpty
          ? Center(child: Text("No Call Logs Found"))
          : ListView.builder(
              itemCount: callLogs.length,
              itemBuilder: (context, index) {
                var log = callLogs[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 196, 207, 227)
                              .withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(1.0),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.phone,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      title: Text(
                        log['name'] ?? "Unknown",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.0),
                          Text("Number: ${log['number']}"),
                          SizedBox(height: 2.0),
                          Text("Duration: ${formatDuration(log['duration'])}"),
                          SizedBox(height: 1.0),
                          Text("Date: ${log['date']}"),
                        ],
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: getCallTypeColor(log['type']),
                          child: Icon(
                            getCallTypeIcon(log['type']),
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

    );
    
  }
IconData getCallTypeIcon(int callType) {
    switch (callType) {
      case 2:
        return Icons.call_missed;

      default:
        return Icons.call_made;
    }
  }
 Color getCallTypeColor(int callType) {
    switch (callType) {
      case 2:
        return Colors.red;
      case 1:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
 
}
