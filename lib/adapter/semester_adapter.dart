import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/entities/semester.dart';

class SemesterAdapter extends ChangeNotifier{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<SemesterModel> semesters = [];

  Future<void> addSemester(SemesterModel semester, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Semesters').add(semester.toMap());
    semester.semid = docRef.id;
    semesters.add(semester);
    changeSemester(semester, context);
    notifyListeners();
  }

  void changeSemester (SemesterModel semester, BuildContext context){
    FirebaseFirestore.instance.collection("Semesters").doc(semester.semid).update(
        semester.toMap()
    );
    notifyListeners();
  }

  Future<void> getSemesters() async {
    List<SemesterModel> temp = [];
    await firebaseFirestore.collection("Semesters").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SemesterModel model = SemesterModel.fromMap(result);
        temp.add(model);
      });
    });
    semesters = temp;
    notifyListeners();
  }
}