
class SubjectModel {
  String? name;
  int? limit;
  int? credit;
  String? semester;
  String? university;
  String? tid;
  int? currentPart;
  String? sid;
  List<String>? quizes;

 SubjectModel({this.name, this.limit, this.credit, this.semester, this.university, this.tid, this.currentPart, this.sid, this.quizes});

  factory SubjectModel.fromMap(map) {
    return SubjectModel(
      name: map['name'],
      limit: map['limit'],
      credit: map['credit'],
      university: map['university'],
      tid: map['tid'],
      currentPart: map['currentpart'],
      semester: map['semester'],
      sid: map['sid'],
        quizes: map["quizes"] == null
            ? null : List<String>.from(map["quizes"]
            .map((x) => x))
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'limit': limit,
      'credit': credit,
      'university': university,
      'tid': tid,
      'currentpart': currentPart,
      'semester': semester,
      'sid': sid,
      "quizes": quizes == null ? null : List<dynamic>.from(quizes!.map((x) => x)),
    };
  }
}