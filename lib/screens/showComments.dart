import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/state/posts.dart';
import 'package:konoha/state/user.dart';
import 'package:provider/provider.dart';
import 'package:konoha/widgets/mods/comment.dart';

class ShowComments extends StatefulWidget {
  final int postIndex;
  ShowComments({this.postIndex});
  @override
  _ShowCommentsState createState() => _ShowCommentsState();
}

class _ShowCommentsState extends State<ShowComments> {
  final TextEditingController commentText = TextEditingController();
  final FocusNode commentNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final postState = Provider.of<PostModel>(context);
    final userState = Provider.of<UserModel>(context).getData;
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: KAppBar(
          title: 'Comments',
          leadingIcon: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          addComment(userState, postState.commentPost,
              postState.posts[widget.postIndex]['_id']),
          commentsList(postState.posts[widget.postIndex]['comments'],
              userState['_id'], media.height, postState.delComment)
        ],
      ),
    );
  }

  Widget addComment(Map user, Function apiCommentPost, String postId) {
    return Row(
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
            apiCommentPost(widget.postIndex, user, postId, commentText.text);
            commentText.clear();
            commentNode.unfocus();
          },
        ),
      ],
    );
  }

  Widget commentsList(
      List comments, String userId, double height, Function delComment) {
    final int length = comments.length;
    return length == 0
        ? Text("No More Comments")
        : comments[length - 1]['imgUrl'] == null
            ? CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                  itemCount: length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == -1) {
                      return Text("No Comments !");
                    }
                    var delButton =
                        userId == comments[index]['commenterId'] ? true : false;
                    return ListTile(
                      title: CommentTile(
                        userName: comments[index]['name'],
                        comment: comments[index]['comment'],
                        imgUrl: comments[index]['imgUrl'],
                        showDelButton: delButton,
                        onDelete: () {
                          delComment(widget.postIndex, index);
                        },
                      ),
                    );
                  },
                ),
              );
  }
}
