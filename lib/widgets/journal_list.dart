import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/screens/journal_details.dart';
import 'package:my_journaling/util/app_colors.dart';
import 'package:my_journaling/util/timestamp_converter.dart';

class JournalList extends StatelessWidget {
  final List<Journal> journals;

  JournalList({this.journals});

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
              leading: Icon(Icons.library_books, color: AppColor.ACCENTCOLOR,),
              title: Text(TimestampConverter.getDayFromTimestamp(journals[index].date)),
              subtitle: Text(TimestampConverter.getFullDateFromTimestamp(journals[index].date)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => JournalDetailsView(journal: journals[index],)));
              },
            )
          ),
        );
      },
    );
  }
}
