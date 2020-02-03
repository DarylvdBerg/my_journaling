import 'package:flutter/material.dart';
import 'package:my_journaling/models/journal.dart';
import 'package:my_journaling/models/question.dart';

class JournalDetailsQuestions extends StatelessWidget {

  final Journal journal;

  JournalDetailsQuestions({this.journal});

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = journal.questions;
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height/4,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(
                    questions[index].question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  ListView.builder(
                    itemCount: questions[index].answers.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int answerIndex){
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          questions[index].answers[answerIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
