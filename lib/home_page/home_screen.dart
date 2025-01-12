// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/call%20_log/ui_call_log.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/home_page/drawer.dart';
import 'package:sales_app/home_page/stat_card.dart';
import 'package:sales_app/home_page/student_card.dart';
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(title: "05", subtitle: "Goal 4450/6000"),
                StatCard(title: "14", subtitle: "Calls Made"),
                StatCard(title: "03", subtitle: "Sales Closed")
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Student to Contact",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 270,
            width: 700,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 395,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: StudentCard(
                    name: "Cool Men",
                    accuracy: "64%",
                    exam: "Neet",
                    tests_attended: 15,
                    high_score: "42/60",
                    speed: "20%",
                    sub: 'bio',
                  ),
                );
              },
            ),
          ),
         
        ],
      ),
    );
  }
}
