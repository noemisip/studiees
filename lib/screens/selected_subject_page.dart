import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/screens/student/start_task.dart';
import 'package:stud_iees/screens/teacher/grades_quizes.dart';
import 'package:stud_iees/screens/teacher/new_quiz.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import '../adapter/grade_adapter.dart';
import '../adapter/quiz_adapter.dart';
import '../adapter/subject_adapter.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../entities/quiz.dart';
import '../entities/subject.dart';
import '../entities/user.dart';
import '../adapter/user_adapter.dart';
import '../widget/my_text.dart';
import '../widget/rounded_shadow_view.dart';

class SelectedSubject extends StatefulWidget {
  const SelectedSubject(
      {Key? key, required this.selectedSubject, required this.function})
      : super(key: key);

  final SubjectModel selectedSubject;
  final String function;

  @override
  _SelectedSubjectPageState createState() {
    return _SelectedSubjectPageState();
  }
}

final DateFormat formatter = DateFormat('yyyy-MM-dd');
GradeAdapter gradeAdapter = GradeAdapter();

class _SelectedSubjectPageState extends State<SelectedSubject> {
  UserAdapter userAdapter = UserAdapter();
  UserModel loggedInUser = UserModel();
  QuizAdapter quizAdapter = QuizAdapter();
  SubjectAdapter subjectAdapter = SubjectAdapter();

  _SelectedSubjectPageState();

  @override
  void initState() {
    super.initState();
    userAdapter = context.read<UserAdapter>();
    gradeAdapter = context.read<GradeAdapter>();
    subjectAdapter = context.read<SubjectAdapter>();
    quizAdapter = context.read<QuizAdapter>();
    userAdapter.getCurrentUser(context).whenComplete(() {
      loggedInUser = userAdapter.currentUser;
      setState(() {});
      userAdapter
          .getTeacherById(widget.selectedSubject.tid ?? "", context)
          .then((value) {
        quizAdapter
            .getQuizesBySubject(widget.selectedSubject.sid ?? "")
            .whenComplete(() {
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    for (var quiz in quizAdapter.quizes) {
      if (quiz.deadline! <
          DateTime.now().millisecondsSinceEpoch -
              const Duration(days: 1).inMilliseconds) {
        quizAdapter.deleteQuizAfterExpired(
            quiz.id!, widget.selectedSubject.sid!);
      }
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(widget.selectedSubject.name ?? "",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            leading: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(widget.selectedSubject.semester.toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            widget.selectedSubject.credit.toString() +
                                " " +
                                tr("credit"),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800)),
                        Text(
                            widget.selectedSubject.currentPart.toString() +
                                "/" +
                                widget.selectedSubject.limit.toString() +
                                " " +
                                tr("students"),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Text(userAdapter.subjTeacher.name ?? "",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800)),
                  if (widget.function == "-" || loggedInUser.role == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(tr("quizes"),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  if (loggedInUser.role == true)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: CupertinoButton(
                        child: Text(
                          tr("create_quiz"),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        color: MyColors.tabBarColor,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  NewQuizPage(subject: widget.selectedSubject));
                        },
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  if (widget.function == "-" || loggedInUser.role == true)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyText(text: tr("type")),
                          MyText(text: tr("name")),
                          MyText(text: tr("deadline")),
                        ],
                      ),
                    ),
                  if (widget.function == "-" || loggedInUser.role == true)
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Consumer<QuizAdapter>(
                          builder: (context, quizAdapter, child) =>
                              quizAdapter.ended == false
                                  ? const LoadingIndicator()
                                  : ListView.builder(
                                      itemCount: quizAdapter.quizes.length,
                                      padding: const EdgeInsets.all(20),
                                      itemBuilder: (context, index) => QuizItem(
                                          subjectAdapter,
                                          quiz: quizAdapter.quizes[index],
                                          type: loggedInUser.role ?? false,
                                          user: loggedInUser)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}

class QuizItem extends StatelessWidget {
  QuizItem(this.subjectAdapter,
      {Key? key, required this.quiz, required this.type, required this.user})
      : super(key: key);

  final QuizModel quiz;
  final bool type;
  final UserModel user;
  late SubjectAdapter subjectAdapter;

  @override
  Widget build(BuildContext context) {
    bool finished = false;
    gradeAdapter.getAllGrades();
    for (var grade in gradeAdapter.allGrades) {
      if (grade.qid == quiz.id && grade.uid == user.uid) {
        finished = true;
      }
    }

    return GestureDetector(
      onTap: () {
        if (type == false && quiz.questions!.isNotEmpty) {
          if (finished == false) {
            showDialog(
                context: context,
                builder: (context) => StartTask(selectedQuiz: quiz));
          }
        }
        if (type == true && quiz.questions!.isNotEmpty) {
          showDialog(
              context: context,
              builder: (context) => GradePage(selectedQuiz: quiz));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RoundedShadowView(
          backgroundColor: MyColors.tabBarColor,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: MyText(
                          fontSize: 17,
                          text: getType(quiz.type.toString(), context.locale))),
                  Expanded(child: MyText(fontSize: 17, text: quiz.name ?? "")),
                  Expanded(
                      child: MyText(
                          fontSize: 17,
                          text: formatter
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  quiz.deadline ?? 0))
                              .toString())),
                  if (finished == true)
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getType(String type, Locale lang) {
    if (lang == const Locale("hu")) {
      if (type == "Homework") {
        return "Házi feladat";
      } else if (type == "Exam") {
        return "Vizsga";
      }
    }

    if (lang == const Locale("en")) {
      if (type == "Házi feladat") {
        return "Homework";
      } else if (type == "Vizsga") {
        return "Exam";
      }
    }
    return type;
  }
}
