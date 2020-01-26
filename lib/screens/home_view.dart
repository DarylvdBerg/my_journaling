import 'package:flutter/material.dart';
import 'package:my_journaling/services/auth.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyJournaling'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text("haai"),
        ),
      ),
    );
  }
}
