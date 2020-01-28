import 'package:flutter/material.dart';
import 'package:my_journaling/widgets/question_textfield.dart';

class JournalQuestions extends StatelessWidget {

  final String question;
  final Function nextQuestion;
  final bool finalQuestion;

  TextEditingController anwser1 = TextEditingController();
  TextEditingController anwser2 = TextEditingController();
  TextEditingController anwser3 = TextEditingController();

  JournalQuestions({this.question, this.nextQuestion, this.finalQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            question,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30,),
          QuestionTextField(
            textHint: "Answer 1",
            controller: anwser1,
          ),
          SizedBox(height: 15,),
          QuestionTextField(
            textHint: "Answer 2",
            controller: anwser2,
          ),
          SizedBox(height: 15,),
          QuestionTextField(
            textHint: "Answer 3",
            controller: anwser3,
          ),
          SizedBox(height: 20,),
          FlatButton(
            onPressed: () => (!finalQuestion) ? nextQuestion(anwser1.text, anwser2.text, anwser3.text)
            : () => {},
            child: (!finalQuestion) ? Text("Next") : Text("Journaling"),
          ),
        ],
      ),
    );
  }
}
