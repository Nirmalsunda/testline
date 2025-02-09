// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sales_app/home_page/navigation/nav_purchase.dart';
import 'package:sales_app/home_page/home_screen.dart';
import 'package:sales_app/home_page/navigation/nav_my_student.dart';
import 'package:sales_app/home_page/user_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentTab = 0;
  final List<Widget> _screen = [
    UserScreen(),
    NavPurchase(),
    NavCallHistory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: _screen[_currentTab],
      ),
      BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Purchase'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Call')
        ],
      ),
    ]);
  }
}
