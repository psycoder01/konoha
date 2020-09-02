import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/bottombar.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/screens/home.dart';
import 'package:konoha/screens/messeges.dart';
import 'package:konoha/screens/account.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _index = 0;
  final List<String> _titles = ["Konoha","Chats","Account"];
  final List<Widget> _pages = [HomeScreen(), MessegeScreen(), AccountScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: KAppBar(
          title: _titles[_index],
          leadingIcon: IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              print('Menu button Pressed');
            },
          ),
          trailIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("Search button Pressed");
              }),
        ),
      ),
      body: _pages[_index],
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
