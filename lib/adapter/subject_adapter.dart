import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/subject.dart';

class SubjectAdapter {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;


  List<SubjectModel> subjects = [];


  Future<void>getSubjects() async{

   await firebaseFirestore.collection("Subjects").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        SubjectModel model = SubjectModel.fromMap(result);
        subjects.add(model);
      });
    });
 print ( subjects.length);
  }

}