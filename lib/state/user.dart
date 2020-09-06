import 'package:flutter/material.dart';
import 'package:konoha/state/keys.dart';
import 'package:konoha/services/api.dart';

class UserModel extends ChangeNotifier {
  UserModel() {
    getLocalToken('token').then((storedToken) {
      token = storedToken;
      if(token != "null"){
        getUserDetails(token);
      }
    });
  }

  String token = "null";
  Map data = {};

  String get getToken => token;
  get getData => data;

  getUserDetails(token) async {
    var res = await getUser(token);
    data = res['data'];
    notifyListeners();
  }
}
