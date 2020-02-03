import 'package:flutter/material.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/util/strings.dart';
import 'package:my_journaling/widgets/journalCounter.dart';
import 'package:my_journaling/widgets/journal_future_builder.dart';

import '../wrapper.dart';
import 'journal_view.dart';

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
        title: Text(Strings.APPNAME),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white),
            label: Text('Logout', style: TextStyle(color: Colors.white),),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            JournalCounter(),
            JournalFutureBuilder()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JournalView()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
