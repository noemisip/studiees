import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/adapter/user_adapter.dart';
import '../entities/subject.dart';
import '../entities/user.dart';

class SubjectAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UserAdapter userAdapter = UserAdapter();
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


  Future<void> getSubjectsByIdBySemester( UserModel user) async {
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("tid", isEqualTo: user.uid).where("semester", isEqualTo: user.currentSemester).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    });
    subjects = temp;
    notifyListeners();
  }

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

  Future<void> getSubjectsBySignedUp( UserModel user) async {
    List<String>? signedUpSubjects = [];
    signedUpSubjects = user.subjects;
    List<SubjectModel> temp = [];
    for( var subject in signedUpSubjects!){
      await firebaseFirestore.collection("Subjects").where("sid", isEqualTo: subject).get().then((value) {
        value.docs.forEach((result) {
          SubjectModel model = SubjectModel.fromMap(result);
          temp.add(model);
          print(model.sid);
        });
      });
      }
    subjects = temp;
    print(subjects.length);
    notifyListeners();
  }

  void changeSubject (SubjectModel subject, BuildContext context){
    FirebaseFirestore.instance.collection("Subjects").doc(subject.sid).update(
        subject.toMap()
    );
    notifyListeners();
  }

  Future<void> signUpSubject( SubjectModel subject, BuildContext context) async{
    int count = subject.current_part ?? 0;
    userAdapter.getUserById(context);
    bool alreadySignedUp = userAdapter.currentUser.subjects!.contains(subject.sid);

    if( subject.limit! > count && !alreadySignedUp ){
      count++;
      subject.current_part = count;
      changeSubject(subject, context);
      await userAdapter.addSubjectToUser(userAdapter.currentUser, subject.sid!, context);
    }
    notifyListeners();
  }

  Future<void> signDownSubject( SubjectModel subject, BuildContext context) async{
    int count = subject.current_part ?? 0;
    userAdapter.getUserById(context);
    bool alreadySignedUp = userAdapter.currentUser.subjects!.contains(subject.sid);

    if( alreadySignedUp ){
      count--;
      subject.current_part = count;
      changeSubject(subject, context);
      await userAdapter.removeSubjectFromUser(userAdapter.currentUser, subject.sid!, context);
      getSubjectsBySignedUp(userAdapter.currentUser);
    }
    notifyListeners();
  }

  Future<void> addSubject(SubjectModel subject, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Subjects').add(subject.toMap());
    subject.sid = docRef.id;
    changeSubject(subject, context);
    getSubjectsById(subject.tid!);
    notifyListeners();
  }
}



