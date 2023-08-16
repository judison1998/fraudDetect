
import 'package:flutter/material.dart';
import 'package:fraud_detector/pages/home.dart';
import 'package:fraud_detector/pages/home1.dart';
import 'package:fraud_detector/pages/login.dart';
import 'package:fraud_detector/pages/start_page.dart';
import 'package:fraud_detector/widgets/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FRAUD DETECTOR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Start(),
    );
  }
}


