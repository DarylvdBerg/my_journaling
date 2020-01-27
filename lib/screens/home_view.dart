import 'package:flutter/material.dart';
import 'package:my_journaling/services/auth.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/widgets/journal_list.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final AuthService _auth = AuthService();
  final JournalService _journalService = new JournalService();

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
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: _journalService.getJournals(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text('loading...');
                  default:
                    if(snapshot.data == null)
                      return Text(
                          'No Journals found!',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                      );
                    else
                      return JournalList(snapshot: snapshot);
                }
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
