import 'package:flutter/material.dart';
import 'package:konoha/services/api.dart';

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

  commentPost(
      int postIndex, String userId, String postId, String comment) async {
    try {
      var res = await apiCommentPost(comment, postId);
      if (res != "Success") return res;
      _posts[postIndex]['comments']
          .add({'commenterId': userId, 'comment': comment});
      _posts[postIndex]['commentsCount'] += 1;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
