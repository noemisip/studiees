
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/entities/question.dart';

class QuestionAdapter extends ChangeNotifier{

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<QuestionModel> questions = [];

  Future<void> addQuiz(QuestionModel question, BuildContext context) async{
    DocumentReference docRef = await firebaseFirestore.collection('Questions').add(question.toMap());
    question.qid = docRef.id;
    questions.add(question);
    notifyListeners();
  }

  Future<void> getQuestionsByQuizes(String qid) async {
    List<QuestionModel> temp = [];
    await firebaseFirestore.collection("Questions").where("qid", isEqualTo: qid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        QuestionModel model = QuestionModel.fromMap(result);
        temp.add(model);
      });
    });
    questions = temp;
    notifyListeners();
  }
}