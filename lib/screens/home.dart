import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:konoha/state/posts.dart';
import 'package:konoha/state/user.dart';
import 'package:konoha/widgets/units/card.dart';
import 'package:konoha/screens/showComments.dart';
import 'package:konoha/constants/configs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postState = Provider.of<PostModel>(context);
    final userState = Provider.of<UserModel>(context);

    return postState.posts == null && userState.getData['_id'] == null
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: postState.posts.length + 1,
              itemBuilder: (BuildContext context, int i) {
                if (i == postState.posts.length) {
                  return Align(
                    child: RaisedButton(
                        child: Text("Load More!"),
                        onPressed: () {
                          print("refresh");
                        }),
                  );
                }
                var author =
                    postState.getAuthorDetails(postState.posts[i]['author']);
                var imgUrl =
                    author[0]['imgUrl'].replaceAll('localhost', localhostIp);
                bool liked = postState.posts[i]['likes']
                    .any((item) => item == userState.getData['_id']);
                bool del =
                    postState.posts[i]['author'] == userState.getData['_id'];
                return ListTile(
                  contentPadding: const EdgeInsets.all(2.0),
                  title: KCard(
                    name: author[0]['name'],
                    content: postState.posts[i]['content'],
                    imgUrl: imgUrl,
                    likesCount: postState.posts[i]['likesCount'],
                    commentsCount: postState.posts[i]['commentsCount'],
                    likePressed: () {
                      postState.likePost(i, userState.getData['_id']);
                    },
                    commentPressed: () {
                      postState.commenters(i, postState.posts[i]['_id']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowComments(
                            postIndex: i,
                          ),
                        ),
                      );
                    },
                    liked: liked,
                    deleteable: del,
                    delPressed: () {
                      postState.deletePost(i);
                    },
                  ),
                );
              },
            ),
            onRefresh: () {
              return postState.setPosts();
            },
          );
  }
}
