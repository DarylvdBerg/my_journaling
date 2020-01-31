import 'package:flutter/material.dart';
import 'package:my_journaling/services/journal.dart';

class JournalCounter extends StatefulWidget {
  @override
  _JournalCounterState createState() => _JournalCounterState();
}

class _JournalCounterState extends State<JournalCounter> {

  final JournalService _journalService = JournalService();
  int count;

  _getUserTotalJournals() {
    setState(() {
      _journalService
          .getUserTotalJournals()
          .then((journals) => {count = journals});
    });
    return count;
  }

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
            Text(
              _getUserTotalJournals().toString(),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
