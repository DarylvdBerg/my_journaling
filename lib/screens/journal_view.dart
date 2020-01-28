import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/models/question.dart';
import 'package:my_journaling/services/journal.dart';
import 'package:my_journaling/util/strings.dart';
import 'package:my_journaling/widgets/journal_content.dart';
import 'package:my_journaling/widgets/journal_questions.dart';

class JournalView extends StatefulWidget {
  @override
  _JournalViewState createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {

  JournalService _journalService = JournalService();

  List<Question> questions = new List<Question>();

  List<String> questionStrings = Strings.questions;
  var _index = 0;
  var _finalQuestion = false;

  void _trackQuestions(List<String> answers) {
    questions.add(new Question(questionStrings[_index]));
    questions[_index].answers = answers;

    if(_index == questionStrings.length) {
      _finalQuestion = true;
    }

    print(questions[_index].question);
    print(questions[_index].answers);

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
        new Journal(journalContent, questions,DateTime.now())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _index < questionStrings.length ?
          JournalQuestions(question: questionStrings[_index], nextQuestion: _questionAnswered, finalQuestion: _finalQuestion) :
          JournalContent(),

    );
  }
}
