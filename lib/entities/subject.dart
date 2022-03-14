
class SubjectModel {
  String? name;
  int? limit;
  int? credit;
  String? semester;
  String? university;
  String? tid;
  int? current_part;
  String? sid;

 SubjectModel({this.name, this.limit, this.credit, this.semester, this.university, this.tid, this.current_part, this.sid});

  factory SubjectModel.fromMap(map) {
    return SubjectModel(
      name: map['name'],
      limit: map['limit'],
      credit: map['credit'],
      university: map['university'],
      tid: map['tid'],
      current_part: map['currentpart'],
      semester: map['semester'],
      sid: map['sid']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'limit': limit,
      'credit': credit,
      'university': university,
      'tid': tid,
      'currentpart': current_part,
      'semester': semester,
      'sid': sid
    };
  }
}