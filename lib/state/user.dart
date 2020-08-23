import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String token = "null";
  Map data = {};

  String get getToken => token;
}
