//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fraud_detector/pages/login.dart';
import 'package:fraud_detector/pages/signUp.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToRegister() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  navigateToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
        
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'WELCOME TO OUR FOOD DELIVERY APPLICATION',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: navigateToLogin,
                  child: Text('sign in'),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: navigateToRegister,
                  child: Text('Register'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
    
          ],
        ),
      ),
    );
  }
}
