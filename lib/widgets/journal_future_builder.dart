import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/widgets/journal_list.dart';

class JournalFutureBuilder extends StatefulWidget {

  final Function journalCounter;

  JournalFutureBuilder({this.journalCounter});

  @override
  _JournalFutureBuilderState createState() => _JournalFutureBuilderState();
}

class _JournalFutureBuilderState extends State<JournalFutureBuilder> {
  final JournalService _journalService = new JournalService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _journalService.getJournals(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Journal> journals = snapshot.data;
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
                return JournalList(journals: journals, journalCounter: widget.journalCounter);
          }
        }
    );
  }
}
