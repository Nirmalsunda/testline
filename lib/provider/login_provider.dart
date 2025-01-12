import 'package:flutter/material.dart';
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
    final String url = "http://app.testline.cloud/admin_api/login";

    try {
      final response =
          await dio.post(url, data: {'email': email, 'password': password});

      if (response.statusCode == 200 && response.data['success'] == true) {
        // Generate JWT token locally
        _token = _generateJwtToken(email, password);

        // Save the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', _token!);

        _isLoggedIn = true;
        notifyListeners();

        print('Login successful! JWT Token: $_token');
        return true;
      } else {
        print('Login failed: ${response.data['message']}');
      }
    } on DioError catch (e) {
      print('Login error: ${e.response?.data ?? e.message}');
    }
    return false;
  }

  /// Generate JWT Token
  String _generateJwtToken(String email, String password) {
    // Header
    final header = {"alg": "HS256", "typ": "JWT"};
    final headerBase64 = base64Url.encode(utf8.encode(json.encode(header)));

    // Payload
    final payload = {"email": email, "password": password};
    final payloadBase64 = base64Url.encode(utf8.encode(json.encode(payload)));

    // Signature
    final dataToSign = "$headerBase64.$payloadBase64";
    final hmac = Hmac(sha256, utf8.encode(secretKey));
    final signature = hmac.convert(utf8.encode(dataToSign)).bytes;
    final signatureBase64 = base64Url.encode(signature);

    return "$headerBase64.$payloadBase64.$signatureBase64";
  }

  /// Logout method
  void logout() async {
    _token = null;
    _isLoggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    notifyListeners();
  }

  /// Auto-login method
  Future<void> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('jwt_token')) {
      _token = prefs.getString('jwt_token');
      if (_token != null) {
        _isLoggedIn = true;
        notifyListeners();
        print('Auto-login successful! JWT Token: $_token');
      }
    }
  }
}
