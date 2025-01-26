// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:sales_app/colors.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String exam;
  final String accuracy;
  final String sub;
  final int tests_attended;
  final String high_score;
  final String speed;
  StudentCard(
      {required this.name,
      required this.accuracy,
      required this.exam,
      // required this.score,
      required this.tests_attended,
      required this.high_score,
      required this.speed,
      required this.sub});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: tlsecondarycolor,
        elevation: 10,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(216)),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  ),
                  Text(name, style: TextStyle(fontSize: 20, color: white)),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.check_circle,
                    size: 18,
                    color: green,
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 0,
              ),
              Text("Exam: $exam", style: TextStyle(color: Colors.red)),
              Divider(),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Subject. : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, color: white)),
                            TextSpan(
                                text: "$sub",
                                style: TextStyle(
                                    fontWeight: FontWeight.w200, color: white))
                          ]),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Tests Attended : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, color: white)),
                          TextSpan(
                              text: "$tests_attended",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, color: white)),
                        ])),
                        SizedBox(
                          height: 7,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Average speed : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, color: white)),
                          TextSpan(
                              text: "$speed",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, color: white))
                        ])),
                        SizedBox(
                          height: 07,
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 65,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Accuracy : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, color: white)),
                          TextSpan(
                              text: "$accuracy",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, color: white))
                        ])),
                        SizedBox(
                          height: 7,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "High Score : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, color: white)),
                          TextSpan(
                              text: "$high_score",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, color: white))
                        ])),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text('View Report',
                        style: TextStyle(color: Colors.white)),
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child:
                          Text('Skip', style: TextStyle(color: Colors.white))),
                ],
              ),
              SizedBox(
                height: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
