import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/entities/quiz.dart';

import '../entities/question.dart';

class QuizAdapter extends ChangeNotifier{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool ended = false;
  List<QuizModel> quizes = [];
  List<String?> questions = [];
  QuizModel currQuiz = QuizModel();

  Future<void> addQuiz(QuizModel quiz, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Quizes').add(quiz.toMap());
    quiz.id = docRef.id;
    changeQuiz(quiz, context);
    quizes.add(quiz);
    notifyListeners();
  }

  void changeQuiz (QuizModel quiz, BuildContext context){
    FirebaseFirestore.instance.collection("Quizes").doc(quiz.id).update(
        quiz.toMap()
    );
    notifyListeners();
  }
  
  Future<void> getQuizesBySubject(String subjid) async {
    List<QuizModel> temp = [];
    await firebaseFirestore.collection("Quizes").where("subjid", isEqualTo: subjid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        QuizModel model = QuizModel.fromMap(result);
        temp.add(model);
      });
    }).whenComplete(() => ended = true);
    quizes = temp;
    notifyListeners();
  }

  Future<void> addQuestionToQuiz(QuestionModel question, String id, BuildContext context) async{
    questions.add(question.qid);
    await firebaseFirestore.collection("Quizes").doc(id).update({"questions": FieldValue.arrayUnion(questions)});
    notifyListeners();
  }

  Future<void> getCurrQuiz(String id) async {
    await firebaseFirestore.collection("Quizes").where("id", isEqualTo: id).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        currQuiz = QuizModel.fromMap(result);
      });
    });
    notifyListeners();
  }

}