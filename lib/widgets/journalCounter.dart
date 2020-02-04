import 'package:flutter/material.dart';
import 'package:my_journaling/services/journal.dart';

class JournalCounter extends StatefulWidget {
  @override
  _JournalCounterState createState() => _JournalCounterState();
}

class _JournalCounterState extends State<JournalCounter> {

  final JournalService _journalService = JournalService();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height/5,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Amount of journals",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            FutureBuilder(
              future: _journalService.getUserTotalJournals(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text("Getting total amount of journals...");
                  default:
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                        fontSize: 30
                      ),
                    );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
