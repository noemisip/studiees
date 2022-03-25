import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/helpers/picturehelper.dart';
import 'package:stud_iees/screens/teacher/new_quiz.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../entities/user.dart';
import '../widget/my_date.dart';
import '../adapter/user_adapter.dart';
class SelectedSubject extends StatelessWidget {
  const SelectedSubject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<MyStatefulWidget>  {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  UserModel userModel = UserModel();
  UserAdapter userAdapter = UserAdapter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text("Targy neve",
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
                    padding: const EdgeInsets.all(20),
                    child: CupertinoButton(
                      child: Text(
                        tr("Create Quiz"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        showDialog(context: context, builder: (context) => NewQuizPage());
                      },
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
