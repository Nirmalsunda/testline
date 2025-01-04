import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _token;
  bool get isLoggedin => _isLoggedIn;
  String? get token => _token;
  final Dio _dio = Dio();

  Future<bool> login(String email, String password) async {
    final String url = "https://reqres.in/api/login";
    _isLoggedIn = true;
    notifyListeners();
    try {
      final response = await _dio.post(
        url,
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        _token = response.data["token"];
        /////////////////////////// /
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        /////////////////////////////
        notifyListeners();
        return true;
      }
    } on DioError catch (e) {
      print("Login Error:");
    } finally {
      _isLoggedIn = false;
      notifyListeners();
    }
    return false;
  }

  void logout() async {
    _token = null;

    _isLoggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _token = prefs.getString('token');
      _isLoggedIn = true;
      notifyListeners();
    }
  }
}
