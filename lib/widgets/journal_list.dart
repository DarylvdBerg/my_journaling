import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';

class JournalList extends StatelessWidget {
  AsyncSnapshot snapshot;

  JournalList({this.snapshot});

  @override
  Widget build(BuildContext context) {
    List<Journal> journals = snapshot.data;
    return ListView.builder(
        itemCount: journals.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: Text(journals[index].date.toString()),
              )
            ],
          );
        },
    );
  }
}
