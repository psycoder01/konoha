import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';

//Models
import 'package:konoha/state/user.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserModel()),
    ], child: Konoha()),
  );
}
