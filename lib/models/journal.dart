import 'package:my_journaling/models/question.dart';

class Journal {
  String uid;
  String journal;
  List<Question> questions;
  DateTime date;

  Journal(this.journal, this.questions, this.date, [this.uid]);
}