class QuizModel {
  String? id;
  String? type;
  String? name;
  int? time;
  List<String>? questions;
  int? fullPoints;
  List<int>? grades;
  String? subjid;
  int? result;


  QuizModel({this.id, this.type, this.name, this.time, this.questions, this.fullPoints, this.grades, this.subjid, this.result});

  factory QuizModel.fromMap(map) {
    return QuizModel(
        id: map['id'],
        type: map['type'],
        name: map['name'],
        time: map['time'],
        result: map['result'],
        subjid: map['subjid'],
        fullPoints: map['full_points'],
      questions: map["questions"] == null
          ? null : List<String>.from(map["questions"]
          .map((x) => x)),
      grades: map["grades"] == null
          ? null : List<int>.from(map["grades"]
          .map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'time': time,
      'result': result,
      'subjid': subjid,
      'full_points': fullPoints,
      'questions': questions == null ? null : List<dynamic>.from(questions!.map((x) => x)),
      'grades': grades == null ? null : List<dynamic>.from(grades!.map((x) => x)),
    };
  }
}