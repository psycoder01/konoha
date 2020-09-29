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
      body: Container(
        color: pureWhite,
        child: ListView(
          children: <Widget>[
            textField(email, 'Email'),
            textField(name, 'Name'),
            textField(bio, 'Bio'),
            textField(nature, 'Nature'),
            textField(location, 'Location'),
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
                      print(email.text);
                      print(name.text);
                      print(bio.text);
                      print(location.text);
                      print(nature.text);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(TextEditingController textController, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: title,
        ),
      ),
    );
  }
}
