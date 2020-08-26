import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';
import 'package:konoha/widgets/units/textinput.dart';
import 'package:konoha/widgets/units/button.dart';
import 'package:konoha/services/validation.dart';
import 'package:konoha/services/api.dart';
import 'package:provider/provider.dart';
import 'package:konoha/state/user.dart';
import 'package:konoha/screens/home.dart';
import 'package:konoha/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loggin = false;
  String loginError;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width;
    var user = Provider.of<UserModel>(context);

    void login() async {
      var email = _emailController.text;
      var pass = _passwordController.text;

      setState(() {
        loggin = true;
      });

      if (!emailCheck(email) && !passCheck(pass)) {
        setState(() {
          loggin = false;
          loginError = 'Credentials mismatched!';
        });
        return null;
      }

      try {
        var resp = await attemptLogin(email, pass);
        if (resp['error'] != null) {
          setState(() {
            loggin = false;
            loginError = resp['error'];
          });
          return null;
        }
        user.token = resp['token'];
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (err) {
        print(err.toString());
        setState(() {
          loggin = false;
          loginError = "Something Oppsy Occured! Try Again Later !";
        });
      }
    }

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryRedColor, primaryBlueColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            SizedBox(height: screenHeight / 6),
            Text(
              'Konoha',
              style: TextStyle(
                fontFamily: 'Inconsolata',
                fontSize: 35.0,
                color: pureWhite,
                letterSpacing: 10.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight / 7),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
              child: Container(
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: pureWhite,
                  ),
                ),
              ),
            ),
            TextInput(textController: _emailController, password: false),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 15.0,
                  color: pureWhite,
                ),
              ),
            ),
            TextInput(textController: _passwordController, password: true),
            Padding(
              padding: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                  fontFamily: 'Inconsolata',
                  fontSize: 10.0,
                  color: pureWhite,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Button(
                title: 'Sign In',
                progress: loggin,
                loader: CircularProgressIndicator(),
                elevation: 2.0,
                height: 70.0,
                color: buttonBgColor,
                hPadding: 100.0,
                onPressed: () {
                  login();
                }),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontFamily: 'Inconsolata',
                    fontSize: 13.0,
                    color: pureWhite,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    " Sign Up",
                    style: TextStyle(
                      fontFamily: 'Inconsolata',
                      fontSize: 13.0,
                      color: buttonBgColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            loginError != null
                ? Text(
                    loginError,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 11.0,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
