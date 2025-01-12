// import "package:flutter/material.dart";
// import 'package:permission_handler/permission_handler.dart';
// import "package:call_log/call_log.dart";
// import 'package:dio/dio.dart';

// Future<bool> requestCallLogPermission() async {
//   PermissionStatus status = await Permission.phone.request();
//   return status.isGranted;
// }

// /////
// Future<List<Map<String, dynamic>>> fetchAllCallLogs() async {
//   Iterable<CallLogEntry> entries = await CallLog.get();
//   return entries.map((entry) {
//     return {
//       "name": entry.name,
//       "number": entry.number,
//       'callType': entry.callType,
//       'timestamp': DateTime.fromMillisecondsSinceEpoch(entry.timestamp!),
//       'duration': entry.duration,
//     };
//   }).toList();
// }
// ////////

// Future<void> sendCallLogsToServer(List<Map<String, dynamic>> callLogs) async {
//   final dio = Dio();
//   const callurl = "";
//   try {
//     final response = await dio.post(callurl,
//         data: {'callLogs': callLogs},
//         options: Options(headers: {'Content-Type': 'application/json'}));
//     print('response from server: ${response.data}');
//   } catch (e) {
//     print("Error sending data to server: $e");
//   }
// }
