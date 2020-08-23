import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget {
  final String title;
  final leadingIcon, trailIcon;

  KAppBar({
    this.title,
    this.leadingIcon,
    this.trailIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily:'Inconsolata',
          ),
        ),
      ),
      leading: leadingIcon,
      actions:<Widget>[
      trailIcon,
      ],
    );
  }
}
