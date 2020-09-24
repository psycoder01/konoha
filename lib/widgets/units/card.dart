import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';

class KCard extends StatelessWidget {
  final String name, imgUrl, content, postId;
  final int likesCount, commentsCount;
  final Function likePressed, commentPressed, delPressed;
  final bool liked, deleteable;
  KCard(
      {this.name,
      this.imgUrl,
      this.content,
      this.postId,
      this.likesCount,
      this.commentsCount,
      this.likePressed,
      this.commentPressed,
      this.liked,
      this.deleteable,
      this.delPressed});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(imgUrl, height: 30.0, width: 30.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 4.0, 2.0, 4.0),
              child: Text(name),
            ),
          ]),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text('   $likesCount'),
              IconButton(
                icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
                color: primaryRedColor,
                onPressed: likePressed,
              ),
              Text('  $commentsCount'),
              IconButton(
                icon: Icon(Icons.comment),
                color: primaryBlueColor,
                onPressed: commentPressed,
              ),
              Spacer(),
              deleteable
                  ? IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: delPressed,
                      color:primaryRedColor,
                    )
                  : Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
