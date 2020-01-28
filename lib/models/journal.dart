import 'package:my_journaling/models/question.dart';

class Journal {
  String uid;
  String journal;
  List<Question> questions;
  DateTime date;

  Journal.empty();

  Journal(this.journal, this.questions, this.date, [this.uid]);


  factory Journal.fromJSON(Map<dynamic, dynamic> json) {
    return Journal(
      json['journal'],
      json['questions'],
      json['date'],
      json['uid']
    );
  }
}