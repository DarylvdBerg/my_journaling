import 'package:flutter/material.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/widgets/journal_list.dart';

class JournalFutureBuilder extends StatelessWidget {

  final JournalService _journalService = new JournalService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
