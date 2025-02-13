// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/provider/api_call_provider.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/loginscreen/login_screen.dart';
import 'package:sales_app/provider/call_log_provider.dart';
import 'package:sales_app/provider/login_provider.dart';
import 'package:sales_app/provider/user_provider.dart';
import 'package:sales_app/services/shared_preferences_service.dart';

class Mydrawer extends StatefulWidget {
  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  String? userEmail;
  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  void _loadUserEmail() {
    setState(() {
      userEmail = SharedPreferencesService.getUserEmail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    final callLogProvider = Provider.of<CallLogProvider>(context);
    final apiCallProvider = Provider.of<ApiCallProvider>(context);

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
                    '${userEmail}',
                    style: TextStyle(fontSize: 20, color: white),
                  )
                ],
              )),
          ListTile(
            title: Text("Total call  ${callLogProvider.totalCallCount}"),
            subtitle: Text('Duration ${callLogProvider.totalCallDuration}'),
            leading: Icon(Icons.call),
          ),
          ListTile(
            title: Text(
              "Official call ${apiCallProvider.totalFilteredCalls}",
            ),
                      leading: Icon(Icons.phone_iphone),
          ),
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
