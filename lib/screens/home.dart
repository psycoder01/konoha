import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:konoha/state/posts.dart';
import 'package:konoha/widgets/units/card.dart';
import 'package:konoha/services/api.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postState = Provider.of<PostModel>(context);

    return postState.posts == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
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
              var author = postState.getAuthorDetails(
                  postState.posts[i]['author']);
              var imgUrl =
                  author[0]['imgUrl'].replaceAll('localhost', '10.0.2.2');
              return ListTile(
                contentPadding: const EdgeInsets.all(2.0),
                title: KCard(
                  name: author[0]['name'],
                  content: postState.posts[i]
                      ['content'],
                  imgUrl: imgUrl,
                ),
              );
            },
          );
  }
}
