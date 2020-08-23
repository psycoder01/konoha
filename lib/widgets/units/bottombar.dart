import 'package:flutter/material.dart';

class KBottomBar extends StatelessWidget {
  final int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
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
