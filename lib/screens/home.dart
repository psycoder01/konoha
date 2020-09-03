import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:konoha/state/posts.dart';
import 'package:konoha/widgets/units/card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<PostModel>(context);
    return appState.posts == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: ListView(
              children: <Widget>[
                KCard(
                  fName: 'Aakash',
                  lName: 'Chaudhary',
                  title: appState.posts[0]['title'],
                  description: appState.posts[0]['description'],
                  imgUrl: "https://picsum.photos/250?image=9",
                ),
              ],
            ),
          );
  }
}
