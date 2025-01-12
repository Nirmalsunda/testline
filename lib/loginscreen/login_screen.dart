// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/colors.dart';
import 'package:sales_app/home_page/home_screen.dart';
import 'package:sales_app/provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool changebutton = false;
  @override
  Widget build(BuildContext context) {
    //provider in final variable
    final authprovider = Provider.of<AuthProvider>(context);
    //
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column( 
            children: [
              Image.asset(
                'assets/testline.png',
                width: 150,
                height: 50,
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFF040728)),
                        borderRadius: BorderRadius.circular(7)),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Enter your email",
                    labelText: 'Email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFF040728),
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    hintText: 'Enter your password',
                    labelText: 'Password'),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  final success = await authprovider.login(email, password);
                  if (success) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomeScreen()));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Login Failed')));
                  }
                },
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                      color: Color(0XFF040728),
                      borderRadius:
                          BorderRadius.circular(changebutton ? 50 : 7)),
                  duration: Duration(seconds: 1),
                  width: changebutton ? 50 : 150,
                  height: 50,
                  alignment: Alignment.center,
                  child: changebutton
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
