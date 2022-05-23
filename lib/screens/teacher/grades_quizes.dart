
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/grade_adapter.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';
import '../../adapter/user_adapter.dart';
import '../../colors.dart';
import '../../entities/quiz.dart';
import '../../widget/loading_indicator.dart';
import '../../widget/my_text.dart';
import '../../widget/rounded_shadow_view.dart';

class GradePage extends StatefulWidget {
  const GradePage( {Key? key, required this.selectedQuiz}) : super(key: key);

  final QuizModel selectedQuiz;

  @override
  _QuizModelState createState()
  {
    return _QuizModelState();
  }
}

class _QuizModelState extends State<GradePage>  {

  QuizAdapter quizAdapter = QuizAdapter();
  UserAdapter userAdapter = UserAdapter();
  GradeAdapter gradeAdapter = GradeAdapter();

  List<String> names = [];

  @override
  void initState() {
    super.initState();

    userAdapter = context.read<UserAdapter>();
    gradeAdapter = context.read<GradeAdapter>();
    quizAdapter= context.read<QuizAdapter>();
    userAdapter.getUsers();
    userAdapter.users.forEach((user) {
      gradeAdapter.getGradeByUidQid(user.uid!, widget.selectedQuiz.id!, context).whenComplete(() {
        gradeAdapter.userIds.forEach((uid) {
          if ( uid == user.uid )
          {
            names.add(user.name!);
            print("==" + user.name!);
            setState(() {
            });

          }
        });
        quizAdapter.getCurrQuiz(widget.selectedQuiz.id!);

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(widget.selectedQuiz.name?? "",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            leading: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Colors.white,))), //leading: Image.asset(Images.pngImgPath('sun'))),
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
              height:  MediaQuery.of(context).size.height / 2,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Consumer<GradeAdapter>(
                  builder: (context, gradeAdapter,child) => gradeAdapter.ended == false
                      ? const LoadingIndicator()
                      : ListView.builder(
                      itemCount: gradeAdapter.grades.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: RoundedShadowView(
                              backgroundColor: MyColors.tabBarColor,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: MyText( text: names[index])),
                                      Expanded(child: MyText( text: gradeAdapter.grades[index].toString())),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),),
                ),
              ),

            ),
          ),
        ));
  }
}