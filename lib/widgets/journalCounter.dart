import 'package:flutter/material.dart';
import 'package:my_journaling/services/journal.dart';

class JournalCounter extends StatefulWidget {
  final int totalAmountOfJournals;

  JournalCounter(this.totalAmountOfJournals);

  @override
  _JournalCounterState createState() => _JournalCounterState();
}

class _JournalCounterState extends State<JournalCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5,
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
              widget.totalAmountOfJournals.toString(),
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
