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
    _posts = result['data']['post'];
    _authors = result['data']['author'];
    notifyListeners();
  }

  getAuthorDetails(id) {
    var filter = _authors.where((author) => author['_id'].contains(id)).toList();
    return filter;
  }
}
