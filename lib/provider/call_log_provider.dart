import 'package:flutter/material.dart';
import 'package:sales_app/call%20_log/call_log_service.dart';

class CallLogProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _callLogs = [];
  List<Map<String, dynamic>> get callLog => _callLogs;

  int _totalCalls = 0;
  int get totalCalls => _totalCalls;

  int _connectedCalls = 0;
  int get connectedCalls => _connectedCalls;

  bool isLoading = false;

  Future<void> fetchLogs(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    CallLogService callLogService = CallLogService();
    _callLogs = callLogService.getSavedLogs();
    notifyListeners();

    List<Map<String, dynamic>> fetchedLogs =
        await callLogService.fetchFilteredLogs(context);
    if (fetchedLogs.isNotEmpty) {
      _callLogs = fetchedLogs;
    }
    _totalCalls = callLogService.getTotalCallCount();
    _connectedCalls = callLogService.getConnectedCallCount();
    isLoading = false;
    notifyListeners();
  }
}
