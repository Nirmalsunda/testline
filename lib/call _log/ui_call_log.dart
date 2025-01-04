// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sales_app/call%20_log/call.dart';

class CallLogScreen extends StatefulWidget {
  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  List<Map<String, dynamic>> callLogs = [];

  @override
  void initState() {
    super.initState();
    fetchAndSendLogs();
  }

  Future<void> fetchAndSendLogs() async {
    if (await requestCallLogPermission()) {
      print('Permission granted');
      List<Map<String, dynamic>> logs = await fetchAllCallLogs();
      print('Fetched Call Logs: $logs');
      await sendCallLogsToServer(logs);
      setState(() {
        callLogs = logs;
      });
    } else {
      print('Permission Denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calling'),
        ),
        body: callLogs.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: callLogs.length,
                itemBuilder: (context, index) {
                  final log = callLogs[index];
                  return ListTile(
                    title: Text(log['Name']??"Unknown"),
                    subtitle: Text('Number: ${log['number']}'),
                    trailing: Text('Duration ${log['duration']}sec'),
                  );
                }));
  }
}
