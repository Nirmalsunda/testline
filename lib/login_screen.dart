import 'package:flutter/material.dart';
import 'package:sales_app/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool changeButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/Fingerprint.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Username', labelText: "Username"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", labelText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    changeButton = true;
                  });
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(seconds:   1),
              
                    width: changeButton ? 50 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: changeButton
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,

                      borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 8),

                      // shape:changeButton ?
                      //  BoxShape.circle : BoxShape.rectangle,
                    ),
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
