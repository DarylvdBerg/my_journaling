import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/models/question.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/util/app_colors.dart';
import 'package:my_journaling/util/strings.dart';
import 'package:my_journaling/widgets/journal_content.dart';
import 'package:my_journaling/widgets/journal_questions.dart';

class JournalView extends StatefulWidget {
  @override
  _JournalViewState createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  JournalService _journalService = JournalService();

  List<Question> questions = new List<Question>();

  List<String> questionStrings = Strings.QUESTIONLIST;
  var _index = 0;

  void _trackQuestions(List<String> answers) {
    questions.add(new Question(questionStrings[_index]));
    questions[_index].answers = answers;

    setState(() {
      _index = _index + 1;
    });

  }

  void _questionAnswered(String answer1, String answer2, String answer3) {
    List<String> answers = new List<String>();
    answers.add(answer1);
    answers.add(answer2);
    answers.add(answer3);

    _trackQuestions(answers);
  }

  void _createJournalItem(String journalContent) {
    _journalService.createNewJournalItem(
        new Journal(journalContent, questions, Timestamp.now())
    );
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text("Journal has been saved"),
      )
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: AppColor.PRIMARYCOLOR,
        title: Text(Strings.APPNAME),
      ),
        body: _index < questionStrings.length ?
          JournalQuestions(question: questionStrings[_index], nextQuestion: _questionAnswered) :
          JournalContent(saveJournal: _createJournalItem),
    );
  }
}
