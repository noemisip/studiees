import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/entities/quiz.dart';

class QuizAdapter extends ChangeNotifier{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<QuizModel> quizes = [];

  Future<void> addQuiz(QuizModel quiz, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Quizes').add(quiz.toMap());
    quiz.id = docRef.id;
    quizes.add(quiz);
    changeQuiz(quiz, context);
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
    });
    quizes = temp;
    notifyListeners();
  }
}