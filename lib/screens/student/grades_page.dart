import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/grade_adapter.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import '../../adapter/user_adapter.dart';
import '../../colors.dart';
import '../../entities/quiz.dart';
import '../../entities/subject.dart';
import '../../entities/user.dart';
import '../../widget/loading_indicator.dart';
import '../../widget/my_text.dart';
import '../../widget/rounded_shadow_view.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  _QuizModelState createState() {
    return _QuizModelState();
  }
}

class _QuizModelState extends State<GradesPage> {
  QuizAdapter quizAdapter = QuizAdapter();
  UserAdapter userAdapter = UserAdapter();
  GradeAdapter gradeAdapter = GradeAdapter();
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserModel loggedInUser = UserModel();
  List<SubjectModel> subjects = [];
  List<QuizModel> quizes = [];
  bool done = false;

  @override
  void initState() {
    super.initState();

    done = false;
    subjects.clear();
    quizes.clear();
    userAdapter = context.read<UserAdapter>();
    gradeAdapter = context.read<GradeAdapter>();
    quizAdapter = context.read<QuizAdapter>();
    subjectAdapter = context.read<SubjectAdapter>();

    userAdapter.getCurrentUser(context).whenComplete(() {
      loggedInUser = userAdapter.currentUser;
      gradeAdapter.getGradeByUid(loggedInUser.uid!, context).whenComplete(() {
        for (var element in gradeAdapter.allGrades) {
          quizAdapter.getCurrQuiz(element.qid!).whenComplete(() {
            quizes.add(quizAdapter.currQuiz);
          }).whenComplete(() {
            subjectAdapter
                .getCurrSubjectById(quizAdapter.currQuiz.subjid!)
                .whenComplete(() {
              subjects.add(subjectAdapter.currSubj);
              if (subjects.length == gradeAdapter.allGrades.length &&
                  quizes.length == gradeAdapter.allGrades.length) {
                setState(() {
                  done = true;
                });
              }
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(tr("grades"),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            leading: CupertinoButton(
                onPressed: () {
                  userAdapter.logout(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))), //leading: Image.asset(Images.pngImgPath('sun'))),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColors.background1, MyColors.background2])),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Consumer<GradeAdapter>(
                  builder: (context, gradeAdapter, child) => gradeAdapter
                              .ended ==
                          false
                      ? const LoadingIndicator()
                      : ListView.builder(
                          itemCount: gradeAdapter.allGrades.length,
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RoundedShadowView(
                              backgroundColor: MyColors.tabBarColor,
                              child: Column(
                                children: [
                                  (done == true)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                                child: MyText(
                                                    text:
                                                        subjects[index].name!)),
                                            Expanded(
                                                child: MyText(
                                                    text: quizes[index].name!)),
                                            Expanded(
                                                child: MyText(
                                                    text: gradeAdapter
                                                        .allGrades[index].grade
                                                        .toString())),
                                          ],
                                        )
                                      : const LoadingIndicator(),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ));
  }
}
