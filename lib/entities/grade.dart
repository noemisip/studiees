class GradeModel {
  String? id;
  String? uid;
  String? qid;
  int? grade;


  GradeModel({this.qid, this.id, this.uid, this.grade});

  factory GradeModel.fromMap(map) {
    return GradeModel(
        qid: map['qid'],
        id: map['id'],
        uid: map['uid'],
        grade: map['grade']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'qid': qid,
      'id': id,
      'uid': uid,
      'grade': grade
    };
  }
}