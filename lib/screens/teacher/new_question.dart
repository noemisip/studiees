
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/adapter/user_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import '../../adapter/question_adapter.dart';
import '../../adapter/quiz_adapter.dart';
import '../../colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../entities/question.dart';
import '../../entities/quiz.dart';
import '../../entities/user.dart';
import '../../widget/my_date.dart';
import '../../widget/my_picker_semester.dart';
import '../../widget/my_picker_type.dart';


class NewQuestionPage extends StatefulWidget {
  NewQuestionPage({Key? key, required this.quiz,  required this.questionAdapter}) : super(key: key);

  final QuizModel quiz;
  late  QuestionAdapter questionAdapter;

  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {

  var question = TextEditingController();
 // QuestionAdapter questionAdapter = QuestionAdapter();

  bool solution = false;
  int point = 1;

  @override
  void initState() {
    super.initState();
    widget.questionAdapter = context.read<QuestionAdapter>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(tr('new_question'),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            leading: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.white,))),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColors.background1, MyColors.background2])),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text(tr("question"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: question,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              hintText: tr("question"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            question.text = value!;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(tr("no"),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))),
                          CupertinoSwitch(
                              value: solution,
                              activeColor: MyColors.background1,
                              onChanged: (value) {
                                setState(() {
                                  solution = value;
                                });
                              }),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(tr("yes"),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("point"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      IntrinsicWidth(
                        child: Row(
                          children: [
                            NumberPicker(
                              itemWidth: 70,
                              textStyle: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
                              selectedTextStyle: TextStyle(fontSize: 20, color: MyColors.background1, fontWeight: FontWeight.w700),
                              step: 1,
                              axis: Axis.horizontal,
                              value: point,
                              minValue: 1,
                              maxValue: 5,
                              onChanged: (value) => setState(() => point = value),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CupertinoButton(
                          child: const Text(
                            "Ok",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                          color: Colors.white,
                          onPressed: () {

                            QuestionModel questionModel = QuestionModel();
                           questionModel.points = point;
                           questionModel.answer = solution;
                           questionModel.question = question.text;

                           widget.questionAdapter.addQuestion(questionModel,context).whenComplete(()
                           {
                             question.clear();
                             print(widget.questionAdapter.questions.length);
                             Navigator.of(context).pop();
                           });
                          },
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
