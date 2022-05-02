import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../entities/grade.dart';
import '../entities/user.dart';

class GradeAdapter extends ChangeNotifier{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GradeModel currgrade = GradeModel();
  List<int> grades = [];
  List<String> userIds = [];

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
    grades.clear();

    await firebaseFirestore.collection("Grades").where("uid", isEqualTo: uid).where("qid", isEqualTo: qid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        currgrade = GradeModel.fromMap(result);
        grades.add(currgrade.grade!);
        userIds.add(currgrade.uid!);
        print("currgrade" + currgrade.grade.toString());
      });
    });
    print("length" + grades.length.toString());
    notifyListeners();
  }


}