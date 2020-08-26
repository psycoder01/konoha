import 'package:flutter/material.dart';

class KAppBar extends StatelessWidget {
  final String title;
  final leadingIcon, trailIcon;
  final double elevation;
  final Color bgColor;

  KAppBar({
    this.title,
    this.leadingIcon,
    this.trailIcon,
    this.elevation:4.0,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:bgColor,
      elevation:elevation,
      title: Container(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Inconsolata',
          ),
        ),
      ),
      leading: leadingIcon,
      actions: <Widget>[
        trailIcon == null ? SizedBox(width:50.0) : trailIcon,
      ],
    );
  }
}
