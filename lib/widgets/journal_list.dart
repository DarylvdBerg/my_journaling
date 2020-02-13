import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/screens/journal_details.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/util/app_colors.dart';
import 'package:my_journaling/util/timestamp_converter.dart';

class JournalList extends StatefulWidget {
  final List<Journal> journals;
  final Function journalCounter;

  JournalList({this.journals, this.journalCounter});

  @override
  _JournalListState createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {
  final JournalService _journalService = JournalService();
  List<Journal> journals;

  void _deleteJournal(String uid) {
    _journalService.deleteJournalItem(uid);
    widget.journalCounter();
    setState(() {
      journals = widget.journals;
    });
  }

  @override
  Widget build(BuildContext context) {
    journals = widget.journals;
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: AppColor.ACCENTCOLOR,
      ),
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.journals.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(widget.journals[index].toString()),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete journal"),
                    content:
                        Text("Are you sure you want to delete this journal?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: AppColor.ACCENTCOLOR),
                        ),
                        onPressed: () {
                          _deleteJournal(journals[index].uid);
                          journals.removeAt(index);
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "No",
                          style: TextStyle(color: AppColor.ACCENTCOLOR),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            background: Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.redAccent,
              child: new Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.white,
                ),
              ),
            ),
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.library_books,
                  color: AppColor.ACCENTCOLOR,
                ),
                title: Text(TimestampConverter.getDayFromTimestamp(
                    journals[index].date)),
                subtitle: Text(TimestampConverter.getFullDateFromTimestamp(
                    journals[index].date)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JournalDetailsView(
                        journal: journals[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
