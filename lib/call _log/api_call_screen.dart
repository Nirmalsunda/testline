import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/provider/api_call_provider.dart';


class ApiCallScreen extends StatefulWidget {
  @override
  _ApiCallScreenState createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  late Future<void> _callLogsFuture;

  @override
  void initState() {
    super.initState();
    _callLogsFuture = fetchCallLogs();
  }

  Future<void> fetchCallLogs() async {
    final apiProvider = Provider.of<ApiCallProvider>(context, listen: false);
    await apiProvider.filterCallLogsFromHive();
  }

  @override
  Widget build(BuildContext context) {
    final apiCallProvider = Provider.of<ApiCallProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('API Call Logs')),
      body: FutureBuilder(
        future: _callLogsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); 
          }

          if (apiCallProvider.filteredCallLogs.isEmpty) {
            return Center(child: Text("No API Calls Found", style: TextStyle(fontSize: 16)));
          }

          return RefreshIndicator(
            onRefresh: fetchCallLogs,
            child: ListView.builder(
              itemCount: apiCallProvider.filteredCallLogs.length,
              itemBuilder: (context, index) {
                final call = apiCallProvider.filteredCallLogs[index];
                return ListTile(
                  leading: Icon(Icons.call, color: Colors.green),
                  title: Text(call['name'] ?? "Unknown"),
                  subtitle: Text(call['number'] ?? "Unknown"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Duration: ${call['duration']} sec"),
                      Text(call['date']),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
