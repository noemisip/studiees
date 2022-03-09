import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../entities/subject.dart';
import '../entities/user.dart';

class SubjectAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<SubjectModel> subjects = [];

  Future<void> getSubjectsById( String id) async {
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("tid", isEqualTo: id).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    });
    subjects = temp;
    notifyListeners();
  }
 /* void changeCurrentSemester(UserModel user){
    FirebaseFirestore.instance.collection("Users").doc(user.uid).update(
        user.toMap()
    );
   // notifyListeners();
  }*/

  Future<void> getSubjectsBySemester( UserModel user) async {
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("university", isEqualTo: user.university).where("semester", isEqualTo: user.currentSemester).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    });
    subjects = temp;
    notifyListeners();
  }

  Future<void> getSubjectsByUniversity( UserModel user) async {
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("university", isEqualTo: user.university).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    });
    subjects = temp;
    notifyListeners();
  }
}



