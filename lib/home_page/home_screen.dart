// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/call%20_log/ui_call_log.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/home_page/drawer.dart';
import 'package:sales_app/home_page/stat_card.dart';
import 'package:sales_app/home_page/student_card.dart';
import 'package:sales_app/home_page/user_screen.dart';
import 'package:sales_app/loginscreen/login_screen.dart';
import 'package:sales_app/provider/login_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/testline.png',
                  height: 100,
                  width: 100,
                ))),
        elevation: 0,
      ),
      drawer: Mydrawer(),
      body: Column(
        children: [
          UserScreen(),
        ],
      ),
    );
  }
}
