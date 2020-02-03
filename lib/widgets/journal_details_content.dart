import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/util/timestamp_converter.dart';

class JournalDetailsContent extends StatelessWidget {

  final Journal journal;

  JournalDetailsContent({this.journal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            TimestampConverter.getFullDateFromTimestamp(journal.date),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Text(
              journal.journal
          ),
        ],
      ),
    );
  }
}
