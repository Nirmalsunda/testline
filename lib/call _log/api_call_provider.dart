import 'dart:async';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sales_app/services/dio_service.dart';

class ApiCallProvider with ChangeNotifier {
  List<Map<String, dynamic>> _filteredCallLogs = [];
  List<String> _apiNumbers = [];
  int _totalFilteredCalls = 0;
  Timer? _timer;

  List<Map<String, dynamic>> get filteredCallLogs => _filteredCallLogs;
  int get totalFilteredCalls => _totalFilteredCalls;

  ApiCallProvider() {
    initApiCalls();
  }
  Future<void> initApiCalls() async {
    await Hive.openBox('apiNumbers');
    await Hive.openBox('callLogs');
    await loadApiNumbers(); 
    await fetchApiNumbers(); 
    startAutoRefresh();
  }

  void startAutoRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      filterCallLogsFromHive();
    });
  }

 //api
  Future<void> fetchApiNumbers() async {
    try {
      final response = await DioConfig().dioServe(
        url: 'http://app.testline.cloud/admin_api/next_lead',
        hasInitToken: true,
        httpMethod: HttpMethod.Get,
      );

      if (response.statusCode == 200) {
        final userData = response.data['user'];
        if (userData != null && userData['phone'] != null) {
          _apiNumbers = [userData['phone']];
          await saveApiNumbers();
          await filterCallLogsFromHive();
          notifyListeners();
        }
      }
    } catch (e) {
      print(" Error fetching API numbers: $e");
    }
  }

  // Save api 
  Future<void> saveApiNumbers() async {
    var box = Hive.box('apiNumbers');
    await box.put('numbers', _apiNumbers);
    print("API Numbers Saved: $_apiNumbers");
  }

  
  Future<void> loadApiNumbers() async {
    var box = Hive.box('apiNumbers');
    _apiNumbers = List<String>.from(box.get('numbers', defaultValue: []));
    print("Loaded API Numbers: $_apiNumbers");
  }

  Future<void> filterCallLogsFromHive() async {
    var box = Hive.box('callLogs');
    List<Map<String, dynamic>> storedLogs = List<Map<String, dynamic>>.from(box.get('logs', defaultValue: []));

    List<Map<String, dynamic>> newFilteredLogs = storedLogs
        .where((log) => _apiNumbers.contains(log['number'])) 
        .toList();

    _filteredCallLogs = newFilteredLogs;
    _totalFilteredCalls = _filteredCallLogs.length;

    print("Filtered Calls: $_totalFilteredCalls");
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }


  

}
