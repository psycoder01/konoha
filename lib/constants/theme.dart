import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';

final ThemeData konohaTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    primaryColor: primaryRedColor,
    accentColor: primaryBlueColor,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: buttonBgColor,
    ),
    scaffoldBackgroundColor: darkWhite,
  );
}
