

class Question {
  String question;
  List<String> answers;

  Question(String question) {
    this.question = question;
    this.answers = new List();
  }

  Question.all({this.question, this.answers});

  Map<String, dynamic> toJson() => {
    'question': question,
    'answers': answers,
  };

  static List<Question> createQuestionList(List list) {
    List<Question> questions = new List();
    for(int i = 0; i < list.length; i++) {
      questions.add(Question.all(question: list[i]['question'], answers: list[i]['answers'].cast<String>()));
    }

    return questions;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question.all(question: json['question'], answers: json['answers']);
  }
}