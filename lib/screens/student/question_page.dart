
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';

import '../../adapter/question_adapter.dart';
import '../../colors.dart';
import '../../entities/quiz.dart';
import 'end_task.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage( {Key? key, required this.questionAdapter, required this.next,required this.quizAdapter, required this.points, required this.time, required this.selectedQuiz}) : super(key: key);

  final QuizAdapter quizAdapter;
  final QuestionAdapter questionAdapter;
  final QuizModel selectedQuiz;
  late int time;
  late int points;
  late int next;


  @override
  _QuestionPageState createState()
  {
    return _QuestionPageState();
  }
}

class _QuestionPageState extends State<QuestionPage>  {

  @override
  void initState() {
    super.initState();
  }

  bool answer = false;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(widget.selectedQuiz.name.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            automaticallyImplyLeading: false
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text((tr("current_points") +" "+ widget.points.toString() + "/" + widget.quizAdapter.currQuiz.maxPoints.toString()),
                      style: const TextStyle( fontSize: 25,
                          color: Colors.white, fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.questionAdapter.currQuestion.points.toString()  + " " + tr("point"),
                          style: const TextStyle( fontSize: 18,
                              color: Colors.white, fontWeight: FontWeight.w600)),
                      Text(widget.time.toString() + " " + tr("minutes"),
                          style: const TextStyle( fontSize: 18,
                              color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text((widget.questionAdapter.currQuestion.question?? ""),
                      style: const TextStyle( fontSize: 25,
                          color: Colors.white, fontWeight: FontWeight.w800)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(tr("false"),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                    CupertinoSwitch(
                        value: answer,
                        activeColor: MyColors.background1,
                        onChanged: (value) {
                          setState(() {
                            answer = value;
                          });
                        }),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(tr("true"),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                  ],
                ),
                CupertinoButton(
                  child: Text(
                    tr("next"),
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    widget.next = widget.next + 1;
                    if( answer == widget.questionAdapter.currQuestion.answer){
                      widget.points += widget.questionAdapter.currQuestion.points!;
                    }
                    if(widget.quizAdapter.currQuiz.questions!.length > widget.next){
                      widget.questionAdapter.getQuestionByQuiz(widget.quizAdapter.currQuiz.questions![widget.next]).whenComplete(() => {
                        showDialog(context: context, builder: (context) =>
                            QuestionPage(selectedQuiz: widget.selectedQuiz, time:  widget.selectedQuiz.time?? 0,
                                points: widget.points, next: widget.next, quizAdapter: widget.quizAdapter, questionAdapter: widget.questionAdapter))
                      });
                    } else {
                      showDialog(context: context, builder: (context) =>
                          EndTask(points: widget.points, quizAdapter: widget.quizAdapter));
                    }
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