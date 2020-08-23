import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textController;
  final bool password;
  TextInput({
    this.textController,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
      child: TextField(
        controller: textController,
        obscureText: password,
        decoration: InputDecoration(
          filled: true,
          fillColor: inputFieldColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
