// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/models/user_data_%20model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewDetailScreen extends StatelessWidget {
  final UserData user;
  const ViewDetailScreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF3F5F8),
        appBar: AppBar(
          backgroundColor: Color(0xffF3F5F8),
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Report',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            color: Color(0xffF3F5F8),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.03),
                                    offset: Offset(0, 5),
                                    blurRadius: 2,
                                    spreadRadius: 2)
                              ]),
                          height: 190,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 72),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '${user.name}',
                                        style: userstyle,
                                        textAlign: TextAlign.center,
                                      ),
                                      subtitle: Text('${user.exam}',
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Icon(Icons.whatshot,
                                      color: Colors.green, size: 25),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  FaIcon(FontAwesomeIcons.whatsapp,
                                      color: Colors.green, size: 25)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: MediaQuery.of(context).size.width / 2 - 60,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.deepOrange,
                                width: 4,
                              )),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/default-profile.jpg'),
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            offset: Offset(0, 5),
                            blurRadius: 2,
                            spreadRadius: 2),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            child: FaIcon(FontAwesomeIcons.listCheck),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  " ${user.completedTests}",
                                  style: userstyle,
                                ),
                                Text(
                                  "Tests",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          FaIcon(
                            FontAwesomeIcons.rightLong,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    " ${user.betterThan}",
                                    style: userstyle,
                                  ),
                                  Text(
                                    "Better than",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          )
                          // SizedBox(
                          //   width: 150,
                          // )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 0),
                            child: FaIcon(FontAwesomeIcons.neuter),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Text(
                                  " ${user.attempt}",
                                  style: userstyle,
                                ),
                                Text(
                                  "Attempt",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          FaIcon(
                            FontAwesomeIcons.expand,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    " ${user.target ?? "0"}",
                                    style: userstyle,
                                  ),
                                  Text(
                                    "Target",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            offset: Offset(0, 5),
                            blurRadius: 2,
                            spreadRadius: 2),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Call :  ---- ',
                          style: userstyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Last Purchase :  ---- ', style: userstyle),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Feedback :  ---- ', style: userstyle),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    // height: 170,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              offset: Offset(0, 5),
                              blurRadius: 2,
                              spreadRadius: 2),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Id: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.id}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                                text: 'Coin:',
                                style: userstyle,
                                children: [
                                  TextSpan(
                                      text: "${user.coins}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400))
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Phone: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.phone}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Email: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.email}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'District: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.district}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Subject: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.subject}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Student type: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.studentType}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Timing: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.timing}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Career stage: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.careerStage}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Current streak: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.currentStreak}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Longest streak: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.longestStreak}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Learner stage: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.learnerStage}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Challenges: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.challenges}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Feature: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.features}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Scholarship: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.interestedScholarship}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Need guidance: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.needGuidance}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Created: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.createdAt}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: 'Updated at: ',
                              style: userstyle,
                              children: [
                                TextSpan(
                                  text: "${user.updatedAt}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
