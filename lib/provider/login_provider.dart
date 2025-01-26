import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/services/dio_service.dart';
import 'package:sales_app/services/shared_preferences_service.dart';
import 'package:sales_app/utils/json_web_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert'; // For base64 encoding
import 'package:crypto/crypto.dart'; // For HMAC SHA-256

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _token;
  bool get isLoggedin => _isLoggedIn;
  String? get token => _token;

  final Dio dio = Dio();
  static const String secretKey =
      'XHxipEZkSmuliB6NDtVc/0UapYiKXMA7GA45nB+GmoWdxxwY4OeUs1XX+TNKfYsSGZ6NyfjqUSNdMHEBA36Zv3xEP5VUHZKI0aFqlvDt9yJ53MfDuBHYTy02wQrpzEaHbdrBH7aflQ6FNPo05tZ5HRQ0eIcKCMMydJLJcBch/1jPzT9T3ESlsosHpH02K/JdLOyRk4eRRSLmWmna1S6dkya68A0WtSGSrjW4kdOGhLAZBwAJHoj1JGo7aO6KEid3vAacdY5atSeg7W3Nf6F7vKepEXGsnqwDO9coVgOS/xloeiSPI4sCELNjkGPr18FLYCyWX7v/z9McAk1SRCsxFnwrfk8zJVsVZOe/DaP8b/Y+8ftnS0jwWv/6RKdcjIVKdSDnPE0VBo+SesWr1KWAlmJIaWg==';

  /// Login method
  Future<bool> login(String email, String password) async {
    final String url = "https://app.testline.cloud/admin_api/login";

    try {
      _token = getToken(email, password);
      SharedPreferencesService.setAuthToken(_token!);
      final response = await DioConfig().dioServe(
        hasInitToken: true,
        url: url,
        httpMethod: HttpMethod.Get,
      );

      if (response.statusCode == 200) {
        // Generate JWT token locally
        _token = getToken(email, password);

        SharedPreferencesService.setAuthToken(_token!);

        _isLoggedIn = true;
        notifyListeners();

        print('Login successful! JWT Token: $_token');
        return true;
      } else {
        print('Login failed: ${response.data['message']}');
      }
    } on DioError catch (e) {
      print('Login error: ${e.response?.data ?? e.message}');
      SharedPreferencesService.setAuthToken(null);
    } catch (e) {
      print('Login error: ${e.toString()}');
      SharedPreferencesService.setAuthToken(null);
    }
    return false;
  }

  static String getToken(String email, String password) {
    final jwt = JsonWebTokenCodec(
        secret:
            '''XHxipEZkSmuliB6NDtVc/0UapYiKXMA7GA45nB+GmoWdxxwY4OeUs1XX+TNKfYsSGZ6NyfjqUSNdMHEBA36Zv3xEP5VUHZKI0aFqlvDt9yJ53MfDuBHYTy02wQrpzEaHbdrBH7aflQ6FNPo05tZ5HRQ0eIcKCMMydJLJcBch/1jPzT9T3ESlsosHpH02K/JdLOyRk4eRRSLmWmna1S6dkya68A0WtSGSrjW4kdOGhLAZBwAJHoj1JGo7aO6KEid3vAacdY5atSeg7W3Nf6F7vKepEXGsnqwDO9coVgOS/xloeiSPI4sCELNjkGPr18FLYCyWX7v/z9McAk1SRCsxFnwrfk8zJVsVZOe/DaP8b/Y+8ftnS0jwWv/6RKdcjIVKdSDnPE0VBo+SesWr1KWAlmJIaWg=--iCiWfJAxN/FYiyTx--LPfiOsx2IcuXrPNsY4S3xQ=='''
                .trim());
    final payload = {'email': email, 'password': password};
    final token = jwt.encode(payload);

    return token;
  }

  void logout() async {
    _token = null;
    _isLoggedIn = false;
    SharedPreferencesService.setAuthToken(null);

    notifyListeners();
  }

  /// Auto-login method
  Future<void> tryAutoLogin() async {
    if (!SharedPreferencesService.isInitialized) {
      print('Error: SharedPreferences is not initialized.');
      return;
    }
    _token = SharedPreferencesService.getAuthToken();
    if (_token != null) {
      _isLoggedIn = true;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });

      print('Auto-login successful! JWT Token: $_token');
    } else {
      print('No valid token found. Auto-login failed.');
    }
  }
}
