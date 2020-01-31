import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_journaling/models/journal.dart';

class JournalList extends StatelessWidget {
  final List<Journal> journals;

  JournalList({this.journals});


  String _getDayFromTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('EEEE').format(date);
  }

  String _getFullDateFromTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd-MM-yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: journals.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Card(
            child: ListTile(
              leading: Icon(Icons.border_color),
              title: Text(_getDayFromTimestamp(journals[index].date)),
              subtitle: Text(_getFullDateFromTimestamp(journals[index].date)),
              onTap: () {
              },
            )
          ),
        );
      },
    );
  }
}
