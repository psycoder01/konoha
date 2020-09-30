import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/constants/colors.dart';
import 'package:konoha/state/user.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController nature = TextEditingController();
  final TextEditingController location = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode bioFocus = FocusNode();
  final FocusNode natureFocus = FocusNode();
  final FocusNode locationFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserModel>(context);

    email.text = userState.getData['email'];
    name.text = userState.getData['name'];
    bio.text = userState.getData['bio'];
    nature.text = userState.getData['nature'];
    location.text = userState.getData['location'];

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
      body: Builder(builder: (BuildContext context) {
        return Container(
          color: pureWhite,
          child: ListView(
            children: <Widget>[
              textField(email, emailFocus, 'Email'),
              textField(name, nameFocus, 'Name'),
              textField(bio, bioFocus, 'Bio'),
              textField(nature, natureFocus, 'Nature'),
              textField(location, locationFocus, 'Location'),
              Container(
                child: Align(
                  child: SizedBox(
                    width: 130,
                    height: 50,
                    child: RaisedButton(
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.person_outline),
                          Text("   Save")
                        ],
                      ),
                      onPressed: () {
                        userState.updateDetails(email.text, name.text, bio.text,
                            nature.text, location.text);
                        clearFocus(emailFocus, nameFocus, bioFocus, natureFocus,
                            locationFocus);
                        final snack = SnackBar(
                          content: Text('Profile Updated !'),
                        );
                        Scaffold.of(context).showSnackBar(snack);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget textField(
      TextEditingController textController, FocusNode focus, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: TextField(
        controller: textController,
        focusNode: focus,
        decoration: InputDecoration(
          labelText: title,
        ),
      ),
    );
  }

  void clearFocus(FocusNode email, FocusNode name, FocusNode bio,
      FocusNode nature, FocusNode location) {
    email.unfocus();
    name.unfocus();
    bio.unfocus();
    nature.unfocus();
    location.unfocus();
  }
}
