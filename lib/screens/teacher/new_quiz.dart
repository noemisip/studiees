
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/adapter/user_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import '../../adapter/quiz_adapter.dart';
import '../../colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../entities/quiz.dart';
import '../../entities/user.dart';
import '../../widget/my_picker_semester.dart';
import '../../widget/my_picker_type.dart';


class NewQuizPage extends StatefulWidget {
  const NewQuizPage({Key? key, required this.subject}) : super(key: key);

  final SubjectModel subject;
  @override
  _NewQuizPageState createState() => _NewQuizPageState();
}

class _NewQuizPageState extends State<NewQuizPage> {

  var name = TextEditingController();
  var time = TextEditingController();
  var maxPoints = TextEditingController();


  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? errorMessage;
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserAdapter userAdapter = UserAdapter();
  QuizAdapter quizAdapter = QuizAdapter();
  MyTypePicker typePicker = MyTypePicker("");

  int grade2 = 40;
  int grade3 = 50;
  int grade4 = 60;
  int grade5 = 80;


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(tr('new_quiz'),
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
                            child: Text(tr("name"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: name,
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
                              hintText: tr("name"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            name.text = value!;
                          },
                        ),
                      ),
                      typePicker,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("time"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: time,
                          keyboardType: TextInputType.number,
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
                              hintText: tr("time"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            time.text = value!;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("max_points"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: maxPoints,
                          keyboardType: TextInputType.number,
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
                              hintText: tr("max_points"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            maxPoints.text = value!;
                          },
                        ),
                      ),
                      IntrinsicWidth(
                        child: Row(
                          children: [
                            const Padding(
                              padding:  EdgeInsets.only(left: 5),
                              child: Text("2",
                                  style:
                                 TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                            NumberPicker(
                              itemWidth: 70,
                              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                              selectedTextStyle: TextStyle(fontSize: 20, color: MyColors.background1, fontWeight: FontWeight.w700),
                              step: 5,
                              value: grade2,
                              minValue: 0,
                              maxValue: 100,
                              onChanged: (value) => setState(() => grade2 = value),
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(left: 5),
                              child: Text("3",
                                  style:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                            NumberPicker(
                              itemWidth: 70,
                              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                              selectedTextStyle: TextStyle(fontSize: 20, color: MyColors.background1, fontWeight: FontWeight.w700),
                              step: 5,
                              value: grade3,
                              minValue: 0,
                              maxValue: 100,
                              onChanged: (value) => setState(() => grade3 = value),
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(left: 5),
                              child: Text("4",
                                  style:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                            NumberPicker(
                              itemWidth: 70,
                              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                              selectedTextStyle: TextStyle(fontSize: 20, color: MyColors.background1, fontWeight: FontWeight.w700),
                              step: 5,
                              value: grade4,
                              minValue: 0,
                              maxValue: 100,
                              onChanged: (value) => setState(() => grade4 = value),
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(left: 5),
                              child: Text("5",
                                  style:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                            NumberPicker(
                              itemWidth: 70,
                              textStyle: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                              selectedTextStyle: TextStyle(fontSize: 20, color: MyColors.background1, fontWeight: FontWeight.w700),
                              step: 5,
                              value: grade5,
                              minValue: 0,
                              maxValue: 100,
                              onChanged: (value) => setState(() => grade5 = value),
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

                            QuizModel quizModel = QuizModel();
                            quizModel.maxPoints = int.parse(maxPoints.text);
                            quizModel.time = int.parse(time.text);
                            quizModel.name = name.text;
                            quizModel.subjid = widget.subject.sid;
                            quizModel.type = typePicker.typeValue;
                            List<int> temp= [];
                            temp.add(grade2);
                           temp.add(grade3);
                           temp.add(grade4);
                            temp.add(grade5);
                            quizModel.grades = temp;

                            quizAdapter.addQuiz(quizModel, context).whenComplete(() {
                              maxPoints.clear();
                              time.clear();
                              name.clear();
                              Navigator.of(context).pop();
                            });

                          },
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          borderRadius: BorderRadius.all(const Radius.circular(20)),
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
