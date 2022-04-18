import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/adapter/user_adapter.dart';
import '../entities/quiz.dart';
import '../entities/subject.dart';
import '../entities/user.dart';

class SubjectAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool ended = false;
  UserAdapter userAdapter = UserAdapter();
  List<SubjectModel> subjects = [];
  List<QuizModel> quizes = [];

  Future<void> getSubjectsById( String id) async {
     ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("tid", isEqualTo: id).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    }).whenComplete(() => ended = true);
    subjects = temp;
    notifyListeners();
  }


  Future<void> getSubjectsByIdBySemester( UserModel user) async {
     ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("tid", isEqualTo: user.uid).where("semester", isEqualTo: user.currentSemester).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    }).whenComplete(() => ended = true);
    subjects = temp;
    notifyListeners();
  }

  Future<void> getSubjectsBySemester( UserModel user) async {
     ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("university", isEqualTo: user.university).where("semester", isEqualTo: user.currentSemester).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    }).whenComplete(() => ended = true);
    subjects = temp;
    notifyListeners();
  }

  Future<void> getSubjectsByUniversity( UserModel user) async {
     ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore.collection("Subjects").where("university", isEqualTo: user.university).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      });
    }).whenComplete(() => ended = true);
    subjects = temp;
    notifyListeners();
  }

  Future<void> getSubjectsBySignedUp( UserModel user) async {
    ended = false;
    List<String>? signedUpSubjects = [];
    signedUpSubjects = user.subjects;
    List<SubjectModel> temp = [];

    if( signedUpSubjects != null){
      for( var subject in signedUpSubjects){
        await firebaseFirestore.collection("Subjects").where("sid", isEqualTo: subject).get().then((value) {
          value.docs.forEach((result) {
            SubjectModel model = SubjectModel.fromMap(result);
            temp.add(model);
          });
        }).whenComplete(() => ended = true);
      }
      subjects = temp;
    }
    notifyListeners();
  }

  Future<void> getAllTasks(UserModel user) async{
    ended = false;
    await getSubjectsBySignedUp(user);
    List<QuizModel> temp = [];

    for( var subject in subjects){
      await firebaseFirestore.collection("Quizes").where("subjid", isEqualTo: subject.sid).get().then((value) {
        value.docs.forEach((result) {
          QuizModel model = QuizModel.fromMap(result);
          temp.add(model);
        });
      }).whenComplete(() => ended = true);
      quizes = temp;
    }
    print(quizes.length);
    notifyListeners();
  }

  Future changeSubject (SubjectModel subject, BuildContext context) async{
    FirebaseFirestore.instance.collection("Subjects").doc(subject.sid).update(
        subject.toMap()
    );
    notifyListeners();
  }

  Future<void> signUpSubject( SubjectModel subject, BuildContext context) async{

    int count = subject.current_part ?? 0;
    userAdapter.getCurrentUser(context).whenComplete(() {
      bool alreadySignedUp = userAdapter.currentUser.subjects!.contains(subject.sid);
      if( subject.limit! > count && !alreadySignedUp){
        count++;
        subject.current_part = count;
        changeSubject(subject, context);
        userAdapter.addSubjectToUser(userAdapter.currentUser, subject.sid!, context);
      }
    });
    notifyListeners();
  }

  Future<void> signDownSubject( SubjectModel subject, BuildContext context) async{
    int count = subject.current_part ?? 0;
    userAdapter.getCurrentUser(context).whenComplete(() async {
      bool alreadySignedUp = userAdapter.currentUser.subjects!.contains(subject.sid);
      if(alreadySignedUp){
        count--;
        subject.current_part = count;
        await changeSubject(subject, context);
        print("**");
        print(userAdapter.currentUser.subjects);
        await userAdapter.removeSubjectFromUser(userAdapter.currentUser, subject.sid!, context);
        await getSubjectsBySignedUp(userAdapter.currentUser);
        notifyListeners();
      }
    });

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



