import 'package:flutter/material.dart';
import 'package:konoha/services/api.dart';

class PostModel extends ChangeNotifier {
  PostModel() {
    setPosts();
    notifyListeners();
  }
  List<dynamic> _posts;
  get posts => _posts;
  void setPosts() async{
    var result = await getPosts();
    _posts = result['data'];
    notifyListeners();
  }
}
