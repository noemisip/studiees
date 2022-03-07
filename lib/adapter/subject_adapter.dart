import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../entities/subject.dart';

class SubjectAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

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


}
