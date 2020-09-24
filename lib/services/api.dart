import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:konoha/state/keys.dart';
import 'package:konoha/constants/configs.dart';

const api = 'http://$localhostIp:5000';

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

Future<Map> apipAddPost(String content) async {
  try {
    var res = await http.post('$api/api/post/',
        headers: {
          HttpHeaders.authorizationHeader: await getLocalToken('token'),
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(<String, String>{'content': content}));
    if (res.statusCode == 400) return {"error": "Error"};
    return json.decode(res.body);
  } catch (err) {
    print(err);
    return {"error": "Not Connected"};
  }
}

Future<String> apiLikePost(String postId) async {
  try {
    var res = await http.post('$api/api/post/$postId/like', headers: {
      HttpHeaders.authorizationHeader: await getLocalToken('token')
    });
    if (res.statusCode == 404) {
      return "Some Error Occured!";
    }
    return "Success";
  } catch (err) {
    print(err);
    return "Some Error Occured";
  }
}

apiUnlikePost(String postId) async {
  try {
    var res = await http.post('$api/api/post/$postId/unlike', headers: {
      HttpHeaders.authorizationHeader: await getLocalToken('token')
    });
    if (res.statusCode == 404) {
      return {"error": res.body};
    }
    return "Success";
  } catch (err) {
    print(err);
    return {"error ": err};
  }
}

Future<Map> apiCommentPost(String comment, String postId) async {
  try {
    var res = await http.post('$api/api/post/$postId/comment',
        headers: {
          HttpHeaders.authorizationHeader: await getLocalToken('token'),
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(<String, String>{'comment': comment}));
    if (res.statusCode == 400) return {"error": "Some Error Occured!"};
    return json.decode(res.body);
  } catch (err) {
    print(err);
    return {"error": "Some Error Occured!"};
  }
}

Future<String> apiDelComment(String postId, String commentId) async {
  try {
    var res = await http.post('$api/api/post/$postId/uncomment',
        headers: {
          HttpHeaders.authorizationHeader: await getLocalToken('token'),
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(<String, String>{'commentId': commentId}));
    if (res.statusCode == 400) return "Server Error!!";
    return "Success";
  } catch (err) {
    print(err);
    return "Server Error!";
  }
}

Future<String> apiDelPost(String postId) async {
  try {
    var res = await http.delete(
      '$api/api/post/$postId/',
      headers: {
        HttpHeaders.authorizationHeader: await getLocalToken('token'),
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );
    if (res.statusCode == 400) return "Server Error!!";
    return "Success";
  } catch (err) {
    print(err);
    return "Server Error!";
  }
}

//User
getUser(token) async {
  try {
    var res = await http.get('$api/api/user/', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: token
    });
    return {"data": json.decode(res.body), "error": null};
  } catch (err) {
    print(err);
    return {"error": err};
  }
}

apiGetUsers(List commenterIds) async {
  try {
    var res = await http.post('$api/api/user/users',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: await getLocalToken('token')
        },
        body: jsonEncode(<String, List>{'userIds': commenterIds}));
    return {"data": json.decode(res.body), "error": null};
  } catch (err) {
    print(err);
    return {"error": err};
  }
}
