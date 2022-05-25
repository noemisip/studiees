import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/question_adapter.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';
import 'package:stud_iees/screens/student/question_page.dart';
import '../../colors.dart';
import '../../entities/quiz.dart';

class StartTask extends StatefulWidget {
  const StartTask({Key? key, required this.selectedQuiz}) : super(key: key);

  final QuizModel selectedQuiz;

  @override
  _QuizModelState createState() {
    return _QuizModelState();
  }
}

class _QuizModelState extends State<StartTask> {
  QuizAdapter quizAdapter = QuizAdapter();
  QuestionAdapter questionAdapter = QuestionAdapter();
  @override
  void initState() {
    super.initState();
    quizAdapter = context.read<QuizAdapter>();
    questionAdapter = context.read<QuestionAdapter>();
    quizAdapter.getCurrQuiz(widget.selectedQuiz.id!).whenComplete(() => questionAdapter.getQuestionByQuiz(quizAdapter.currQuiz.questions![0]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(widget.selectedQuiz.type ?? "",
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(widget.selectedQuiz.name.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          (widget.selectedQuiz.questions?.length.toString() ??
                                  "") +
                              " " +
                              tr("questions"),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      Text(
                          widget.selectedQuiz.time.toString() +
                              " " +
                              tr("minutes"),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                CupertinoButton(
                  child: const Text(
                    "Start",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return QuestionPage(
                              selectedQuiz: widget.selectedQuiz,
                              endTime: DateTime.now().millisecondsSinceEpoch +
                                  1000 * 60 * (widget.selectedQuiz.time ?? 0),
                              points: 0,
                              next: 0,
                              quizAdapter: quizAdapter,
                              questionAdapter: questionAdapter);
                        });
                  },
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ],
            ),
          ),
        ));
  }
}
