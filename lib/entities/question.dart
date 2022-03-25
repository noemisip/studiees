class QuestionModel {
  String? qid;
  String? question;
  bool? answer;
  int? points;


  QuestionModel({this.qid, this.question, this.answer, this.points});

  factory QuestionModel.fromMap(map) {
    return QuestionModel(
      qid: map['qid'],
      question: map['question'],
      answer: map['answer'],
        points: map['points']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'qid': qid,
      'question': question,
      'answer': answer,
      'points': points
    };
  }
}