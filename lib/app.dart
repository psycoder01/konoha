import 'package:flutter/material.dart';

// Importing Screens
import 'screens/home.dart';
import 'screens/login.dart';
import 'package:konoha/state/user.dart';
import 'package:provider/provider.dart';

class Konoha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String token = Provider.of<UserModel>(context).token;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konoha',
      home: token != "null" ? HomeScreen() : LoginScreen(),
    );
  }
}
