import 'package:flutter/material.dart';
import 'package:konoha/constants/colors.dart';
import 'package:konoha/widgets/units/appbar.dart';
import 'package:konoha/widgets/units/textinput.dart';
import 'package:konoha/widgets/units/button.dart';
import 'package:konoha/services/api.dart';
import 'package:konoha/services/validation.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    void signup() async {
      setState(() {
        loading = true;
      });
      var email = _emailController.text;
      var pass = _passwordController.text;
      var fName = _fNameController.text;

      if (!emailCheck(email) && !passCheck(pass)) {
        setState(() {
          loading = false;
          error = 'Credentials Mismatched!';
        });
        return null;
      }
      try {
        var resp = await attemptSignUp(email, pass, fName);
        if (resp['error'] != null) {
          setState(() {
            loading = false;
            error = resp['error'];
          });
          return null;
        }
        setState(() {
          loading = false;
          error = "Arigato for Registering. Redirecting to Login!";
        });
        Future.delayed(const Duration(milliseconds: 5000), () {
          Navigator.pop(context);
        });
      } catch (err) {
        print(err.toString());
        setState(() {
          loading = false;
          error = "Something Oppsy Occured! Try Again Later !";
        });
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(38.0),
        child: KAppBar(
          title: 'Join',
          elevation: 0.0,
          bgColor: transpColor,
          leadingIcon: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        width: screen.width,
        height: screen.height,
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
            padding: const EdgeInsets.only(top: 0),
            children: <Widget>[
              SizedBox(height: 70.0),
              Text(
                'Konoha',
                style: TextStyle(
                  fontFamily: 'Inconsolata',
                  fontSize: 25.0,
                  color: pureWhite,
                  letterSpacing: 3.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
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
                padding: const EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: pureWhite,
                  ),
                ),
              ),
              TextInput(textController: _fNameController, password: false),
              SizedBox(height: 20.0),
              Button(
                title: 'Haai',
                progress: loading,
                loader: CircularProgressIndicator(),
                elevation: 2.0,
                height: 70.0,
                color: buttonBgColor,
                hPadding: 100.0,
                onPressed: () {
                  signup();
                },
              ),
              SizedBox(height: 20.0),
              error != null
                  ? Text(
                      error,
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
