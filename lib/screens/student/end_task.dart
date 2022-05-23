import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/grade_adapter.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';
import '../../adapter/user_adapter.dart';
import '../../app_router.dart';
import '../../colors.dart';
import '../../entities/grade.dart';
import '../../entities/user.dart';


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

  UserAdapter userAdapter = UserAdapter();
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    userAdapter = context.read<UserAdapter>();
    userAdapter.getCurrentUser(context).whenComplete((){
      loggedInUser = userAdapter.currentUser;
      setState(() {
      });
    });
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(tr("your_score"),
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                          (widget.points.toString() +
                              " / " +
                              widget.quizAdapter.currQuiz.maxPoints.toString() +" " +
                              tr("points")),
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
                          tr("your_grade") + ": "+ getGrade((widget.points /
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

                        GradeAdapter gradeAdapter = GradeAdapter();
                        GradeModel grade = GradeModel();
                        grade.qid = widget.quizAdapter.currQuiz.id;
                        grade.grade = getGrade((widget.points /
                            widget.quizAdapter.currQuiz.maxPoints! *
                            100).toInt());
                        grade.uid = userAdapter.currentUser.uid;
                        gradeAdapter.addGrade(grade, context);
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
