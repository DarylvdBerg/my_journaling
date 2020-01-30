import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';

class JournalList extends StatelessWidget {
//  final AsyncSnapshot snapshot;
  final List<Journal> journals;

  JournalList({this.journals});


  String _formatDate(Timestamp timestamp) {
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: journals.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
              title: Text(journals[index].journal),
            )
          ],
        );
      },
    );
  }
}
