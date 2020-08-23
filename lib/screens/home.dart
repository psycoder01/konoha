import 'package:flutter/material.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/widgets/units/bottombar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: KAppBar(
          title: 'Konoha',
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
      body: Center(
        child: Text('Homepage'),
      ),
      bottomNavigationBar: KBottomBar(),
    );
  }
}
