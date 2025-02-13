// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sales_app/call%20_log/api_call_screen.dart';
import 'package:sales_app/home_page/navigation/nav_filter_call.dart';
import 'package:sales_app/home_page/home_screen.dart';
import 'package:sales_app/home_page/navigation/nav_call.dart';
import 'package:sales_app/home_page/user_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentTab = 0;
  final List<Widget> _screen = [
    UserScreen(),
    ApiCallScreen(),
    NavCallHistory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen [_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Call'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'AllCall')
        ],
      ),
    );
  }
}
