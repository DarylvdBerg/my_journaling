import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_journaling/models/question.dart';

class Journal {
  String uid;
  String journal;
  List<Question> questions;
  Timestamp date;

  Journal.empty();

  Journal(this.journal, this.questions, this.date, [this.uid]);


  Map<String, dynamic> toJson() => {
    'uid': uid,
    'journal': journal,
    'questions': encodeToJson(questions),
    'date': date,
  };


  static List encodeToJson(List<Question> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(json['journal'], json['questions'].cast<Question>(), json['date'], json['uid']);
  }
}