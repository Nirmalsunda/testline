import 'dart:async';
import 'package:call_e_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CallLogProvider with ChangeNotifier {
  List<Map<String, dynamic>> _callLogs = [];
  int _totalCallCount = 0;
  int _totalCallDuration = 0;
  Timer? _timer;

  List<Map<String, dynamic>> get callLogs => _callLogs;
  int get totalCallCount => _totalCallCount;
  int get totalCallDuration => _totalCallDuration;

  CallLogProvider() {
    initCallLogs();
  }

   Future<void> initCallLogs() async {
    await Hive.openBox('callLogs');
    await requestPermissions();
    await loadCallLogs(); 
    await fetchCallLogs(); 
    startAutoRefresh();
  }

  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      Permission.contacts,
      
    ].request();

    bool granted = statuses[Permission.phone] == PermissionStatus.granted;

    if (!granted) {
      print(" Permission Denied! Open App Settings");
      openAppSettings();
    }

    return granted;
  }
 void startAutoRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchCallLogs();
    });
  }
  Future<void> fetchCallLogs() async {
    if (await requestPermissions()) {
      try {
        Iterable<CallLogEntry> logs = await CallLog.get();
        print("Total Call Logs Fetched: ${logs.length}");

        List<Map<String, dynamic>> newLogs = logs.map((log) => {
          'name': log.name ?? 'Unknown',
          'number': log.number ?? 'Unknown',
          'duration': log.duration ?? 0,
          'date': log.timestamp != null
              ? DateTime.fromMillisecondsSinceEpoch(log.timestamp!).toString()
              : 'Unknown',
          'type': log.callType?.index ?? 0,
        }).toList();

        _callLogs = newLogs;
        _totalCallCount = _callLogs.length;
        _totalCallDuration = _callLogs.fold(0, (sum, log) => sum + (log['duration'] as int));

        await saveCallLogs();
        notifyListeners();
      } catch (e) {
        print(" Error fetching call logs: $e");
      }
    }
  }

    Future<void> saveCallLogs() async {
    var box = Hive.box('callLogs');
    await box.put('logs', _callLogs);
    await box.put('total_count', _totalCallCount);
    await box.put('total_duration', _totalCallDuration);
    print(" Call Logs Saved to Hive!");
  }

   Future<void> loadCallLogs() async {
    var box = Hive.box('callLogs');
    _callLogs = List<Map<String, dynamic>>.from(box.get('logs', defaultValue: []));
    _totalCallCount = box.get('total_count', defaultValue: 0);
    _totalCallDuration = box.get('total_duration', defaultValue: 0);
    print("Call Logs Loaded from Hive!");
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

String formatDuration(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int secs = seconds % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
}
