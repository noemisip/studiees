import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import '../../colors.dart';
import '../../entities/user.dart';
import '../selected_subject_page.dart';
import '../subjects_page.dart';


class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}): super(key: key);

  @override
  _AllTasksState createState()
  {
    return _AllTasksState();
  }
}

class _AllTasksState extends State<AllTasks>  {

  _AllTasksState();

  User? user = FirebaseAuth.instance.currentUser;
  SubjectAdapter subjectAdapter = SubjectAdapter();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      subjectAdapter = context.read<SubjectAdapter>();
    subjectAdapter.getAllTasks(loggedInUser);
 });
        }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(tr("all_tasks"),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
            leading: CupertinoButton(
                onPressed: () {
                  userAdapter.logout(context);
                },
                child: const Icon(
                  Icons.logout,
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
                  Container(
                    height:  MediaQuery.of(context).size.height,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Consumer<SubjectAdapter>(
                        builder: (context, subjectAdapter,child) => subjectAdapter.quizes.isEmpty
                            ? const LoadingIndicator()
                            : ListView.builder(
                            itemCount: subjectAdapter.quizes.length,
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) =>
                                QuizItem(quiz: subjectAdapter.quizes[index], type: loggedInUser.role?? false)),
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

