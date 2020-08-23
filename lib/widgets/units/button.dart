import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final bool progress;
  final loader;
  final double elevation, height, hPadding;
  final Function onPressed;
  final Color color;

  Button(
      {this.elevation: 5.0,
      this.title,
      this.height: 10.0,
      this.onPressed,
      this.color,
      this.hPadding: 10.0,
      this.progress,
      this.loader});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: hPadding),
      child: RaisedButton(
        child: progress
            ? loader
            : Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  color: pureWhite,
                ),
              ),
        color: color,
        elevation: elevation,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
