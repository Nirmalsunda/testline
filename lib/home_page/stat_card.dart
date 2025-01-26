// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sales_app/colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;

  StatCard({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: tlsecondarycolor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12)]),
      child: Column(
        children: [
          Text(
            title,
            style: titlestyle,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: subtitlestyle,
          )
        ],
      ),
    );
  }
}
