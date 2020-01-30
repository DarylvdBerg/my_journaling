class Question {
  String question;
  List<String> answers;

  Question(String question) {
    this.question = question;
    this.answers = new List();
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'answers': answers,
  };

}