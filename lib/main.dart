import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';

//Models
import 'package:konoha/state/user.dart';
import 'package:konoha/state/keys.dart';
import 'package:konoha/state/posts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Initializer(token: await getLocalToken('token')));
}

class Initializer extends StatelessWidget {
  final String token;

  Initializer({this.token});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => PostModel())
      ],
      child: Konoha(token: token),
    );
  }
}
