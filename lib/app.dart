import 'package:flutter/material.dart';

// Importing Screens
import 'screens/home.dart';
import 'screens/login.dart';

class Konoha extends StatelessWidget {
  final String token;
  Konoha({this.token,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Konoha',
      home: LoginScreen(),
      //initialRoute: '/login',
      //onGenerateRoute: _getRoute,
    );
  }

  //Route<dynamic> _getRoute(RouteSettings settings) {
    //if (settings.name != '/login') {
      //return null;
    //}

    //return MaterialPageRoute<void>(
      //settings: settings,
      //builder: (BuildContext context) => LoginScreen(),
    //);
  //}
}
