// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/loginscreen/login_screen.dart';
import 'package:sales_app/provider/login_provider.dart';
import 'package:sales_app/provider/user_provider.dart';

class Mydrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    //final userprovider = Provider.of<UserProvider>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: tlprimarycolor),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/Fingerprint.png",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sales Manager',
                    style: TextStyle(fontSize: 20, color: white),
                  )
                ],
              )),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                            onPressed: () {
                              authprovider.logout();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
                            },
                            child: Text('Logout'))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
