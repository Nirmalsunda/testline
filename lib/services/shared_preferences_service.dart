import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesService {
  static late SharedPreferences prefs;
  static const String _authToken = "_authToken";
  static const String _preference = "_preference";
  
  Future<bool> initPrefs() async {
    try {
      prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      return true;
    } catch (e) {
      _isInitialized = false;
      return false;
    }
  }
  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  
  static void setAuthToken(String? token) {
    //prefs.setString(_authToken, token);
    if(
token==null
    ){
      prefs.remove(_authToken);
    }else{
       prefs.setString(_authToken, token!);
    }
  }

  static String? getAuthToken() {
    return prefs.getString(_authToken);
  }

  
}