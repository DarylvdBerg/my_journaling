import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/util/strings.dart';
import 'package:my_journaling/widgets/journal_details_content.dart';
import 'package:my_journaling/widgets/journal_details_questions.dart';

class JournalDetailsView extends StatelessWidget {
  final Journal journal;

  JournalDetailsView({this.journal});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Strings.APPNAME),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                label: Text(''),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.library_books,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.question_answer,
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              JournalDetailsContent(journal: this.journal),
              JournalDetailsQuestions(journal: this.journal,)
            ],
          ),
        ),
      ),
    );
  }
}
