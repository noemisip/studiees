import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../entities/grade.dart';

class GradeAdapter extends ChangeNotifier{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GradeModel currGrade = GradeModel();
  List<int> grades = [];
  List<String> userIds = [];
  List<GradeModel> allGrades = [];
  bool ended = false;

  Future<void> addGrade(GradeModel grade, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Grades').add(grade.toMap());
    grade.id = docRef.id;
    changeGrade(grade, context);
    notifyListeners();
  }

  void changeGrade (GradeModel grade, BuildContext context){
    FirebaseFirestore.instance.collection("Grades").doc(grade.id).update(
        grade.toMap()
    );
    notifyListeners();
  }

  Future<void> getGradeByUidQid ( String uid,String qid, BuildContext context) async{
    ended = false;
    grades.clear();

    await firebaseFirestore.collection("Grades").where("uid", isEqualTo: uid).where("qid", isEqualTo: qid).get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        currGrade = GradeModel.fromMap(result);
        grades.add(currGrade.grade!);
        userIds.add(currGrade.uid!);
      }
    });
    notifyListeners();
    ended = true;
  }

  Future<void> getGradeByUid ( String uid,BuildContext context) async{
    ended = false;
    allGrades.clear();

    await firebaseFirestore.collection("Grades").where("uid", isEqualTo: uid).get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        currGrade = GradeModel.fromMap(result);
        allGrades.add(currGrade);
      }
    });
    notifyListeners();
    ended = true;
  }

  Future<void> getAllGrades() async{
    ended = false;

    List<GradeModel> temp = [];

    await firebaseFirestore.collection("Grades").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        GradeModel model = GradeModel.fromMap(result);
        temp.add(model);
      }
    });
    allGrades = temp;
    notifyListeners();
    ended = true;
  }

}