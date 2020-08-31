import 'package:flutter/material.dart';

class KBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function onTabTapped;
  KBottomBar({this.currentIndex: 0, this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5.0,
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      onTap: onTabTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text(''),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          title: Text(''),
        ),
      ],
    );
  }
}
