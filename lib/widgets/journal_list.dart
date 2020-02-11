import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/screens/journal_details.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/util/app_colors.dart';
import 'package:my_journaling/util/timestamp_converter.dart';

class JournalList extends StatelessWidget {
  final List<Journal> journals;
  final JournalService journalService = JournalService();

  JournalList({this.journals});

  void _deleteJournal(String uid) {
    journalService.deleteJournalItem(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: AppColor.ACCENTCOLOR,
      ),
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: journals.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(journals[index].toString()),
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
                        onPressed: () => _deleteJournal(journals[index].uid),
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
