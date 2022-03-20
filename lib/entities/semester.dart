
class SemesterModel {
  String? semid;
  String? semester;

  SemesterModel({this.semester, this.semid});

  factory SemesterModel.fromMap(map) {
    return SemesterModel(
        semester: map['semester'],
        semid: map['semid'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'semester': semester,
      'semid': semid,
    };
  }
}