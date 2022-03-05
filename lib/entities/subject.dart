
class SubjectModel {
  String? name;
  int? limit;
  int? credit;
  String? semester;
  String? university;
  String? tid;
  int? current_part;

 SubjectModel({this.name, this.limit, this.credit, this.semester, this.university, this.tid, this.current_part});

  factory SubjectModel.fromMap(map) {
    return SubjectModel(
      name: map['name'],
      limit: map['limit'],
      credit: map['credit'],
      university: map['university'],
      tid: map['tid'],
      current_part: map['currentpart'],
      semester: map['semester'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'limit': limit,
      'credit': credit,
      'university': university,
      'semester': semester,
      'currentpart': current_part,
      'tid': tid,
    };
  }
}