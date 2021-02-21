import 'package:flutter/material.dart';
import 'package:pointage/models/brew.dart';
import 'package:pointage/screens/home/pointage.dart';
import 'package:pointage/services/auth.dart';
import 'package:pointage/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Pointage'),
          backgroundColor: Colors.indigo[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fond.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Pointage()),
      ),
    );
  }
}
