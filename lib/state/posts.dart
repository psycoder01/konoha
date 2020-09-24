import 'package:flutter/material.dart';
import 'package:konoha/services/api.dart';
import 'package:konoha/constants/configs.dart';

class PostModel extends ChangeNotifier {
  PostModel() {
    setPosts();
  }
  List<dynamic> _posts;
  List<dynamic> _authors;
  get posts => _posts;
  get authors => _authors;

  void setPosts() async {
    var result = await getPosts();
    _posts = result['data']['post'].reversed.toList();
    _authors = result['data']['author'];
    notifyListeners();
  }

  getAuthorDetails(id) {
    return _authors.where((author) => author['_id'].contains(id)).toList();
  }

  addPost(String comment, Map user) async {
    try {
      var res = await apipAddPost(comment);
      if (res["error"] != null) return res;
      _posts.insert(0, res);
      var check = _authors.where((item) => item['_id'] == user['_id']);
      if (check.length == 0) {
        var newUser = {
          "_id": user['_id'],
          "name": user['name'],
          "email": user['email'],
          "imgUrl": user['imgUrl']
        };
        _authors.add(newUser);
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  likePost(int postIndex, String userId) {
    if (_posts[postIndex]['likes'].any((item) => item == userId)) {
      _posts[postIndex]['likesCount'] -= 1;
      apiUnlikePost(_posts[postIndex]['_id']).then((resp) {
        if (resp != "Success") {
          _posts[postIndex]['likesCount'] += 1;
          _posts[postIndex]['likes'].add(userId);
        }
        notifyListeners();
      }).catchError((err) {
        print(err);
      });
      _posts[postIndex]['likes'].removeWhere((item) => item == userId);
    } else {
      _posts[postIndex]['likesCount'] += 1;
      apiLikePost(_posts[postIndex]['_id']).then((resp) {
        if (resp != "Success") {
          _posts[postIndex]['likesCount'] -= 1;
          _posts[postIndex]['likes'].removeWhere((item) => item == userId);
        }
        notifyListeners();
      }).catchError((err) {
        print(err);
      });
      _posts[postIndex]['likes'].add(userId);
    }
    notifyListeners();
  }

  commentPost(int postIndex, Map user, String postId, String comment) async {
    try {
      var res = await apiCommentPost(comment, postId);
      if (res['error'] != null) return res;
      res['name'] = user['name'];
      res['imgUrl'] = await user['imgUrl'].replaceAll('localhost', localhostIp);
      _posts[postIndex]['comments'].add(res);
      _posts[postIndex]['commentsCount'] += 1;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  commenters(int postIndex, String postId) async {
    var len = _posts[postIndex]['commentsCount'];
    try {
      var commenterIds = [];
      _posts[postIndex]['comments']
          .forEach((item) => commenterIds.add(item['commenterId']));
      var res = await apiGetUsers(commenterIds);
      for (var i = 0; i < len; i++) {
        var commenterId = commenterIds[i];
        var user = await res['data'].where((item) {
          if (item['_id'] == commenterId)
            return true;
          else
            return false;
        }).toList();

        _posts[postIndex]['comments'][i]['name'] = user[0]['name'];
        _posts[postIndex]['comments'][i]['imgUrl'] =
            user[0]['imgUrl'].replaceAll('localhost', localhostIp);
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  delComment(int postIndex, int commentIndex) async {
    try {
      var res = await apiDelComment(_posts[postIndex]['_id'],
          _posts[postIndex]['comments'][commentIndex]['_id']);
      if (res != "Success") return;
      _posts[postIndex]['comments'].removeAt(commentIndex);
      _posts[postIndex]['commentsCount'] -= 1;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  deletePost(int postIndex) async {
    try {
      var res = await apiDelPost(_posts[postIndex]['_id']);
      if (res != "Success") return;
      _posts.removeAt(postIndex);
      notifyListeners();
      return res;
    } catch (err) {
      print(err);
      return "Error";
    }
  }
}
