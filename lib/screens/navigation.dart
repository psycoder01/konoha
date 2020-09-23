import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/bottombar.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/screens/home.dart';
import 'package:konoha/screens/messeges.dart';
import 'package:konoha/screens/account.dart';
import 'package:konoha/state/keys.dart';
import 'package:konoha/state/user.dart';
import 'package:provider/provider.dart';
import 'package:konoha/constants/colors.dart';
import 'package:konoha/screens/addPost.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _index = 0;
  final List<String> _titles = ["Konoha", "Chats", "Account"];
  final List<Widget> _pages = [HomeScreen(), MessegeScreen(), AccountScreen()];
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: KAppBar(
          title: _titles[_index],
          leadingIcon: IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              delToken('token');
            },
          ),
          trailIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print(userState.token);
              }),
        ),
      ),
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline, size: 40.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPost()),
          );
        },
        backgroundColor: primaryBlueColor,
      ),
      bottomNavigationBar: KBottomBar(
        currentIndex: _index,
        onTabTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
