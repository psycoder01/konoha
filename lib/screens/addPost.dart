import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/constants/colors.dart';
import 'package:konoha/state/posts.dart';
import 'package:provider/provider.dart';
import 'package:konoha/state/user.dart';

class AddPost extends StatelessWidget {
  final TextEditingController postText = TextEditingController();
  final FocusNode postTextFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final postState = Provider.of<PostModel>(context);
    final userState = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: KAppBar(
          title: 'Post',
          leadingIcon: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        width: media.width,
        height: media.height,
        color: pureWhite,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Spill It Out",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Poppins",
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                maxLines: 3,
                controller: postText,
                focusNode: postTextFocus,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryBlueColor,
                        width: 3.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryBlueColor,
                        width: 2.0,
                      ),
                    ),
                    hintText: "Enter the words of your inner place! "),
              ),
            ),
            Container(
              width: media.width * 0.3,
              child: RaisedButton(
                elevation: 10.0,
                child: Row(
                  children: <Widget>[Icon(Icons.done_outline), Text("   POST")],
                ),
                onPressed: () {
                  postState.addPost(postText.text,userState.getData);
                  postTextFocus.unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
