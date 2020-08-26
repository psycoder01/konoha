import 'package:flutter/material.dart';

// Importing Screens
import 'screens/home.dart';
import 'screens/login.dart';

class Konoha extends StatelessWidget {
  final String token;
  Konoha({this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konoha',
      //home: token != "null" ? HomeScreen() : LoginScreen(),
      home: LoginScreen(),
    );
  }
}
