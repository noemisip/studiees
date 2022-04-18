import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';

import '../../adapter/question_adapter.dart';
import '../../app_router.dart';
import '../../colors.dart';
import '../../entities/quiz.dart';

class EndTask extends StatefulWidget {
  EndTask({Key? key, required this.quizAdapter, required this.points})
      : super(key: key);

  final QuizAdapter quizAdapter;
  late int points;

  @override
  _EndTaskState createState() {
    return _EndTaskState();
  }
}

class _EndTaskState extends State<EndTask> {
  @override
  void initState() {
    super.initState();
  }

  int getGrade(int result) {
    if (widget.quizAdapter.currQuiz.grades![0] > result) {
      return 1;
    } else if (widget.quizAdapter.currQuiz.grades![1] > result) {
      return 2;
    } else if (widget.quizAdapter.currQuiz.grades![2] > result) {
      return 3;
    } else if (widget.quizAdapter.currQuiz.grades![3] > result) {
      return 4;
    } else {
      return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(widget.quizAdapter.currQuiz.name ?? "",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
          automaticallyImplyLeading: false,
            ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColors.background1, MyColors.background2])),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Your score:",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                          (widget.points.toString() +
                              " / " +
                              widget.quizAdapter.currQuiz.maxPoints.toString() +
                              " Points"),
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                          (widget.points /
                                      widget.quizAdapter.currQuiz.maxPoints! *
                                      100)
                                  .toInt()
                                  .toString() +
                              "%",
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                          "Your grade: " + getGrade((widget.points /
                              widget.quizAdapter.currQuiz.maxPoints! *
                              100).toInt()).toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    CupertinoButton(
                      child: const Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouter.student_home, (route) => false);
                      },
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
