// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/call%20_log/call_log_service.dart';
import 'package:sales_app/provider/call_log_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CallLogScreen extends StatefulWidget {
  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CallLogProvider>(context, listen: false)
        .fetchLogs(context));
  }

  Widget build(BuildContext context) {
    final callLogProvider = Provider.of<CallLogProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Call History'),
        ),
        body: callLogProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : callLogProvider.callLog.isEmpty
                ? Center(
                    child: Text('No call'),
                  )
                : ListView.builder(
                    itemCount: callLogProvider.callLog.length,
                    itemBuilder: (context, index) {
                      final log = callLogProvider.callLog[index];
                      return ListTile(
                        title: Text(log['name']),
                        subtitle: Text('📱 ${log['number']}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(log['callType']),
                            Text('⏳ ${log['duration']}sec'),
                          ],
                        ),
                        onTap: () async {
                          final Uri url =
                              Uri(scheme: 'tel', path: log['number']);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print('Could not launch $url');
                          }
                        },
                      );
                    }));
  }
}
