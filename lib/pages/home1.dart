//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraud_detector/pages/start_page.dart';

import '../widgets/colors.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isLoggedIn = false;

  checkAuthentification()async{
    _auth.authStateChanges().listen((user) {
      if(user==null){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Start()
        ));
      }
    });
  }
  getUser()async{
    User firebaseUser = await _auth.currentUser!;
    await firebaseUser.reload();
    firebaseUser= _auth.currentUser!;
    if(firebaseUser!=null){
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn=true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WELCOME TO HOME PAGE'),
        centerTitle: true,
        backgroundColor: AppColors.maincolor,
      ),
      body: Container(
        child: !isLoggedIn? CircularProgressIndicator():Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              height: 150,
              width: double.maxFinite,
              color: AppColors.maincolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('hellow ${user.displayName}'),
                  Text(
                    'order your product now',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
              
                  SizedBox(
                    height: 10,
                  ),
              
          ],
        ),
      ),
    ])
    )
    );
  }
}
