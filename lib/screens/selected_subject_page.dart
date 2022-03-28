import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/helpers/picturehelper.dart';
import 'package:stud_iees/screens/student/signed_subjects_page.dart';
import 'package:stud_iees/screens/teacher/new_quiz.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import '../adapter/quiz_adapter.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../entities/quiz.dart';
import '../entities/subject.dart';
import '../entities/user.dart';
import '../widget/my_date.dart';
import '../adapter/user_adapter.dart';
import '../widget/my_text.dart';
import '../widget/rounded_shadow_view.dart';


class SelectedSubject extends StatefulWidget {
  const SelectedSubject( {Key? key, required this.selectedSubeject}) : super(key: key);

  final SubjectModel selectedSubeject;


  @override
  _SelectedSubjectPageState createState()
  {
    return _SelectedSubjectPageState();
  }
}

class _SelectedSubjectPageState extends State<SelectedSubject>  {
  String? errorMessage;
  UserModel userModel = UserModel();
  UserAdapter userAdapter = UserAdapter();
  UserModel loggedInUser = UserModel();
  QuizAdapter quizAdapter = QuizAdapter();
  User? user = FirebaseAuth.instance.currentUser;

  _SelectedSubjectPageState();

  @override
  void initState() {
    super.initState();
    userAdapter = context.read<UserAdapter>();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      quizAdapter = context.read<QuizAdapter>();
      userAdapter.getTeacherById(widget.selectedSubeject.tid?? "", context).then((value) {
        quizAdapter.getQuizesBySubject(widget.selectedSubeject.sid??"").whenComplete(() {
          setState(() {
            print(quizAdapter.quizes.length);
          });
        });
      });
  });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(widget.selectedSubeject.name?? "",
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(widget.selectedSubeject.semester.toString(),
                        style: const TextStyle( fontSize: 18,
                            color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.selectedSubeject.credit.toString()+" " +tr("credit"),
                            style: const TextStyle( fontSize: 18,
                                color: Colors.white, fontWeight: FontWeight.w800)),
                        Text(widget.selectedSubeject.current_part.toString()+"/"+widget.selectedSubeject.limit.toString()+" "+tr("students"),
                            style: const TextStyle( fontSize: 18,
                                color: Colors.white, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Text(userAdapter.subjTeacher.name?? "",
                      style: const TextStyle( fontSize: 18,
                          color: Colors.white, fontWeight: FontWeight.w800)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(tr("quizes"),
                            style: const TextStyle( fontSize: 18,
                                color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                  if(loggedInUser.role == true)Padding(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoButton(
                      child: Text(
                        tr("Create Quiz"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        showDialog(context: context, builder: (context) => NewQuizPage(subject: widget.selectedSubeject));
                      },
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  Container(
                    height:  MediaQuery.of(context).size.height / 2,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Consumer<QuizAdapter>(
                          builder: (context, quizAdapter,child) => quizAdapter.quizes.isEmpty
                              ? const LoadingIndicator()
                              : ListView.builder(
                              itemCount: quizAdapter.quizes.length ?? 0,
                              padding: const EdgeInsets.all(20),
                              itemBuilder: (context, index) =>
                                  QuizItem(quiz: quizAdapter.quizes[index], type: loggedInUser.role?? false)),
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
  const QuizItem({Key? key, required this.quiz, required this.type}) : super(key: key);

  final QuizModel quiz;
  final bool type;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RoundedShadowView(
          backgroundColor: MyColors.tabBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyText(text: quiz.type.toString()),
          MyText(text: quiz.name ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
