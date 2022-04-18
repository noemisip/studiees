import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../entities/grade.dart';

class GradeAdapter extends ChangeNotifier{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addGrade(GradeModel grade, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Grades').add(grade.toMap());
    grade.id = docRef.id;
    changeGrade(grade, context);;
    notifyListeners();
  }

  void changeGrade (GradeModel grade, BuildContext context){
    FirebaseFirestore.instance.collection("Grades").doc(grade.id).update(
        grade.toMap()
    );
    notifyListeners();
  }
}