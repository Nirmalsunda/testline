// import 'package:dio/dio.dart';
// ignore_for_file: avoid_print

import 'package:firebase_performance/firebase_performance.dart';

import 'package:flutter/material.dart';
import 'package:sales_app/models/user_data_%20model.dart';
import 'package:sales_app/services/dio_service.dart';

class UserProvider extends ChangeNotifier {
  UserData? currentUser;
  int currentUserId = 1;

  Future<void> fetchUser() async {
    try {
      // final dioConfig = DioConfig();
      final response = await DioConfig().dioServe(
          url: 'http://app.testline.cloud/admin_api/next_lead',
          hasInitToken: true,
          httpMethod: HttpMethod.Get);
      if (response.statusCode == 200) {
        final userData = response.data['user'];
        if (userData != null) {
          currentUser = UserData.fromJson(userData);
          print('API Response: $userData');
          notifyListeners();
        } else {
          print('user data is null in response');
        }
      } else {
        print('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void nextuser() {
    currentUserId++;
    fetchUser();
  }
}
