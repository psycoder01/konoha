import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:konoha/state/keys.dart';

const api = 'http://10.0.2.2:5000';

Map<String, String> header = {
  HttpHeaders.contentTypeHeader: 'application/json'
};

//Authentication
attemptLogin(String email, String password) async {
  try {
    var resp = await http.post("$api/api/auth/login",
        headers: header,
        body: json.encode({
          'email': email,
          'password': password,
        }));
    if (resp.statusCode == 400) {
      return {"error": resp.body};
    }
    await storeToken('token', resp.body);
    return {"token": resp.body, "error": null};
  } catch (err) {
    return {"error": err};
  }
}

attemptSignUp(String email, String password, String fName) async {
  try {
    var resp = await http.post('$api/api/auth/register',
        headers: header,
        body:
            json.encode({'email': email, 'password': password, 'name': fName}));
    if (resp.statusCode != 200) {
      return {'error': resp.body};
    }
    return {"messege": resp.body, "error": null};
  } catch (err) {
    return {"error": err};
  }
}

//Post
getPosts() async {
  try {
    var res = await http.get('$api/api/post/');
    return {"data": json.decode(res.body), "error": null};
  } catch (err) {
    print(err);
    return {"error": err};
  }
}
