// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/home_page/view_user_detail.dart';
import 'package:sales_app/provider/user_provider.dart';
import 'package:shimmer/shimmer.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<UserProvider>(context, listen: false).fetchUser());
  }

  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Call: 1',
              style: userstyle,
            ),
            Column(
              children: [
                Text(
                  'Goal: 100001',
                  style: userstyle,
                ),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    color: const Color.fromARGB(255, 21, 45, 125),
                    value: 4450 / 6000,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              ],
            ),
            Text(
              'Sales: 07',
              style: userstyle,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 300,
                  //margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 10))
                      ]),
                  child: userprovider.currentUser == null
                      ? Shimmer.fromColors(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 240,
                                height: 12,
                                color: const Color.fromARGB(120, 186, 182, 182),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _buildSkeletonText(250, 10), 
                              SizedBox(
                                height: 7,
                              ),
                              _buildSkeletonText(250, 10), 
                              SizedBox(height: 9),
                              _buildSkeletonText(250, 10), 
                              SizedBox(height: 13),
                              _buildSkeletonText(220, 7), 
                              SizedBox(height: 10),
                              _buildSkeletonText(250, 10),
                              SizedBox(height: 12),
                              _buildSkeletonText(250, 10), 
                              SizedBox(height: 6),
                              _buildSkeletonText(250, 5), 
                              SizedBox(height: 12),
                              _buildSkeletonText(200, 10), 
                              SizedBox(height: 7),
                              _buildSkeletonText(250, 10),
                            ],
                          ),
                          baseColor: const Color.fromARGB(120, 158, 158, 158)!,
                          highlightColor:
                              const Color.fromARGB(255, 255, 255, 255)!)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "Id :  ${userprovider.currentUser!.id}                              "
                                      "Coin :  ${userprovider.currentUser!.coins}",
                                  style: userstyle)
                            ])),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Name :  ${userprovider.currentUser!.name}',
                              style: userstyle,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Contact :  ${userprovider.currentUser!.phone}',
                              style: userstyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Exam :  ${userprovider.currentUser!.exam}',
                              style: userstyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Subject :  ${userprovider.currentUser!.subject}',
                              style: userstyle,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Test :  ${userprovider.currentUser!.completedTests}',
                              style: userstyle,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Career :  ${userprovider.currentUser!.careerStage}',
                              style: userstyle,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Attempt :  ${userprovider.currentUser!.attempt}',
                              style: userstyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Target :  ${userprovider.currentUser!.target}',
                              style: userstyle,
                            )
                          ],
                        )),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewDetailScreen(user: userprovider.currentUser!),
                    ));
              },
              child: Text(
                'View',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 7,
                  minimumSize: Size(100, 40)),
            ),
            ElevatedButton(
              onPressed: () {
                userprovider.nextuser();
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 7,
                  minimumSize: Size(100, 40)),
            ),
          ],
        ),
        // Container(height: 100, color: Colors.black)
      ],
    );
  }

  _buildSkeletonText(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
    );
  }
}
