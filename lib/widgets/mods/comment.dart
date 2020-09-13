import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';

class CommentTile extends StatelessWidget {
  final String comment;
  final Function onDelete;
  final String imgUrl;
  final String userName;
  final bool showDelButton;
  CommentTile(
      {this.comment,
      this.showDelButton,
      this.onDelete,
      this.imgUrl,
      this.userName});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imgUrl,
                      height: 20.0,
                      width: 20.0,
                    ),
                  ),
                ),
                Text(
                  '$userName',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding:const EdgeInsets.fromLTRB(8.0,0,0,0),
              child: Text(
                '$comment',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Spacer(),
        showDelButton
            ? IconButton(
                icon: Icon(Icons.delete),
                color: primaryBlueColor,
                onPressed: onDelete,
              )
            : Text(''),
      ],
    );
  }
}
