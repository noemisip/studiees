import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/entities/question.dart';

class QuestionAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<QuestionModel> questions = [];
  QuestionModel currQuestion = QuestionModel();

  Future<void> addQuestion(QuestionModel question, BuildContext context) async {
    DocumentReference docRef =
        await firebaseFirestore.collection('Questions').add(question.toMap());
    question.qid = docRef.id;
    changeQuestion(question, context);
    questions.add(question);
    notifyListeners();
  }

  void changeQuestion(QuestionModel question, BuildContext context) {
    FirebaseFirestore.instance
        .collection("Questions")
        .doc(question.qid)
        .update(question.toMap());
    notifyListeners();
  }

  Future<void> getQuestionByQuiz(String qid) async {
    await firebaseFirestore
        .collection("Questions")
        .where("qid", isEqualTo: qid)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        QuestionModel model = QuestionModel.fromMap(result);
        currQuestion = model;
      }
    });
    notifyListeners();
  }
}
