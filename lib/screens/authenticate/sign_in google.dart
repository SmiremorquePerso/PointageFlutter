import 'package:flutter/material.dart';
import 'package:pointage/screens/home/home.dart';
import 'package:pointage/services/auth.dart';
import 'package:pointage/shared/loading.dart';

class SignInGoogle extends StatefulWidget {
  final Function toggleView;
  SignInGoogle({this.toggleView});

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  final AuthService _auth = AuthService();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Pointage",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.brown[400]),
                    ),
                    SizedBox(height: 20.0),
                    Image(image: AssetImage("assets/logo.jpg"), height: 200.0),
                    SizedBox(height: 50),
                    _signInButton(),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        setState(() => loading = true);
        dynamic result = await _auth.signInWithGoogle();
        if (result == null) {
          setState(() {
            loading = false;
            error = 'Could not sign in with those credentials';
          });
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
