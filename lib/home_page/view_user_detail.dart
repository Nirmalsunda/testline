// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/models/user_data_%20model.dart';

class ViewDetailScreen extends StatelessWidget {
  final UserData user;
  const ViewDetailScreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User details'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 150,
              width: 330,
              decoration: BoxDecoration(
                  color: Color(0xff0C2A42),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  ListTile(
                    title: Text('${user.name}',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    subtitle: Text('${user.exam}'),
                  )
                ],
              ),
            ),
          ),
          Text('Name: ${user.name}')
        ],
      ),
    );
  }
}
