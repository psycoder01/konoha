import 'package:flutter/material.dart';
import 'package:konoha/widgets/mods/comment.dart';

class CommentDialog extends StatefulWidget {
  CommentDialog(
      {Key key, this.postIndex, this.post, this.addComment, this.user})
      : super(key: key);
  final int postIndex;
  final Map post, user;
  final Function addComment;
  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  final TextEditingController commentText = TextEditingController();
  final FocusNode commentNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    List comments = widget.post['comments'].reversed.toList();

    return Dialog(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        height: screen.height / 2,
        width: screen.width * 0.8,
        child: ListView.builder(
          itemCount: widget.post['commentsCount'] + 1,
          itemBuilder: (BuildContext context, int j) {
            if (j == 0) {
              return new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: commentText,
                      focusNode: commentNode,
                      decoration: InputDecoration(
                        hintText: "Enter Your Comment",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      widget.addComment(widget.postIndex, widget.user['_id'],
                          widget.post['_id'], commentText.text);
                      commentText.clear();
                      commentNode.unfocus();
                    },
                  ),
                ],
              );
            }
            var userName = 'SomeOne';
            var imgUrl = 'https://picsum.photos/200';
            bool delButton =
                widget.user['_id'] == comments[j - 1]['commenterId'];
            return ListTile(
              title: CommentTile(
                userName: userName,
                imgUrl: imgUrl,
                comment: comments[j - 1]['comment'],
                onDelete: () {
                  print("Delete comment");
                },
                showDelButton:delButton,
              ),
            );
          },
        ),
      ),
    );
  }
}
