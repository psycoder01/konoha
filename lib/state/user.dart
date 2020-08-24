import 'package:flutter/material.dart';
import 'package:konoha/state/keys.dart';

class UserModel extends ChangeNotifier {
  UserModel() {
    getLocalToken('token').then((storedToken) {
      token = storedToken;
      notifyListeners();
    });
  }

  String token = "null";
  Map data = {};

  String get getToken => token;
}
