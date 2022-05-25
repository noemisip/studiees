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
  SubjectModel currSubj = SubjectModel();

  Future<void> getCurrSubjectById(String sid) async {
    ended = false;
    await firebaseFirestore
        .collection("Subjects")
        .where("sid", isEqualTo: sid)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        SubjectModel model = SubjectModel.fromMap(result);
        currSubj = model;
      }
    });
    notifyListeners();
    ended = true;
  }

  Future<void> getSubjectsById(String id) async {
    ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore
        .collection("Subjects")
        .where("tid", isEqualTo: id)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      }
    });
    subjects = temp;
    notifyListeners();
    ended = true;
  }

  Future<void> getSubjectsByIdBySemester(UserModel user) async {
    ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore
        .collection("Subjects")
        .where("tid", isEqualTo: user.uid)
        .where("semester", isEqualTo: user.currentSemester)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      }
    });
    subjects = temp;
    notifyListeners();
    ended = true;
  }

  Future<void> getSubjectsBySemester(UserModel user) async {
    ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore
        .collection("Subjects")
        .where("university", isEqualTo: user.university)
        .where("semester", isEqualTo: user.currentSemester)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      }
    });
    subjects = temp;
    notifyListeners();
    ended = true;
  }

  Future<void> getSubjectsByUniversity(UserModel user) async {
    ended = false;
    List<SubjectModel> temp = [];
    await firebaseFirestore
        .collection("Subjects")
        .where("university", isEqualTo: user.university)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        SubjectModel model = SubjectModel.fromMap(result);
        temp.add(model);
      }
    });
    subjects = temp;
    notifyListeners();
    ended = true;
  }

  Future<void> getSubjectsBySignedUp(UserModel user) async {
    ended = false;
    List<String>? signedUpSubjects = [];
    signedUpSubjects = user.subjects;
    List<SubjectModel> temp = [];

    if (signedUpSubjects != null) {
      for (var subject in signedUpSubjects) {
        await firebaseFirestore
            .collection("Subjects")
            .where("sid", isEqualTo: subject)
            .get()
            .then((value) {
          for (var result in value.docs) {
            SubjectModel model = SubjectModel.fromMap(result);
            temp.add(model);
          }
        });
      }
      subjects = temp;
    }
    notifyListeners();
    ended = true;
  }

  Future<void> getSubjectsBySignedUpBySemester(
      UserModel user, String semester) async {
    ended = false;
    List<String>? signedUpSubjects = [];
    signedUpSubjects = user.subjects;
    List<SubjectModel> temp = [];

    if (signedUpSubjects != null) {
      for (var subject in signedUpSubjects) {
        await firebaseFirestore
            .collection("Subjects")
            .where("sid", isEqualTo: subject)
            .where("semester", isEqualTo: semester)
            .get()
            .then((value) {
          for (var result in value.docs) {
            SubjectModel model = SubjectModel.fromMap(result);
            temp.add(model);
          }
        });
      }
      subjects = temp;
    }
    notifyListeners();
    ended = true;
  }

  Future<void> getAllTasks(UserModel user) async {
    ended = false;
    await getSubjectsBySignedUp(user);
    List<QuizModel> temp = [];

    for (var subject in subjects) {
      await firebaseFirestore
          .collection("Quizes")
          .where("subjid", isEqualTo: subject.sid)
          .get()
          .then((value) {
        for (var result in value.docs) {
          QuizModel model = QuizModel.fromMap(result);
          temp.add(model);
        }
      });
      quizes = temp;
    }
    notifyListeners();
    ended = true;
  }

  Future changeSubject(SubjectModel subject, BuildContext context) async {
    FirebaseFirestore.instance
        .collection("Subjects")
        .doc(subject.sid)
        .update(subject.toMap());
    notifyListeners();
  }

  Future<void> signUpSubject(SubjectModel subject, BuildContext context) async {
    int count = subject.currentPart ?? 0;
    userAdapter.getCurrentUser(context).whenComplete(() {
      bool alreadySignedUp;
      if (userAdapter.currentUser.subjects != null) {
        alreadySignedUp =
            userAdapter.currentUser.subjects!.contains(subject.sid);
      } else {
        alreadySignedUp = false;
      }
      if (subject.limit! > count && !alreadySignedUp) {
        count++;
        subject.currentPart = count;
        changeSubject(subject, context);
        userAdapter.addSubjectToUser(
            userAdapter.currentUser, subject.sid!, context);
      }
    });
    notifyListeners();
  }

  Future<void> signDownSubject(
      SubjectModel subject, BuildContext context) async {
    int count = subject.currentPart ?? 0;
    userAdapter.getCurrentUser(context).whenComplete(() async {
      bool alreadySignedUp =
          userAdapter.currentUser.subjects!.contains(subject.sid);
      if (alreadySignedUp) {
        count--;
        subject.currentPart = count;
        await changeSubject(subject, context);
        await userAdapter
            .removeSubjectFromUser(
                userAdapter.currentUser, subject.sid!, context)
            .whenComplete(() => getSubjectsBySignedUp(userAdapter.currentUser));
      }
    });
    notifyListeners();
  }

  Future<void> addSubject(SubjectModel subject, BuildContext context) async {
    DocumentReference docRef =
        await firebaseFirestore.collection('Subjects').add(subject.toMap());
    subject.sid = docRef.id;
    changeSubject(subject, context);
    getSubjectsById(subject.tid!);
    notifyListeners();
  }
}
