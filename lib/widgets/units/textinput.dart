import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textController;
  final String hint;
  final bool password;
  TextInput({
    this.textController,
    this.password,
    this.hint : '',
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
          hintText:hint,
          fillColor: inputFieldColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
