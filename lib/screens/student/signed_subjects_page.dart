import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import 'package:stud_iees/widget/my_picker_semester.dart';
import 'package:stud_iees/widget/my_text.dart';
import '../../adapter/user_adapter.dart';
import '../../colors.dart';
import '../../entities/user.dart';
import '../../widget/rounded_shadow_view.dart';
import '../subjects_page.dart';

class SignedSubjectPage extends StatefulWidget {
  const SignedSubjectPage({Key? key}) : super(key: key);


  @override
  _SignedSubjectPageState createState() => _SignedSubjectPageState();
}


class _SignedSubjectPageState extends State<SignedSubjectPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserAdapter userAdapter = UserAdapter();


  @override
  initState()  {
    super.initState();
    userAdapter = context.read<UserAdapter>();
    subjectAdapter = context.read<SubjectAdapter>();
    userAdapter.getCurrentUser(context).whenComplete((){
      loggedInUser = userAdapter.currentUser;
      setState(() {
        subjectAdapter.getSubjectsBySignedUp(loggedInUser);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.background1,
          centerTitle: true,
          title: Text(tr('subjects'),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800)),
          leading: CupertinoButton(
              onPressed: () {
                userAdapter.logout(context);
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ))),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [MyColors.background1, MyColors.background2])),
        child:  Column(
          children: [
            MyPicker("", signedup: true),
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Consumer<SubjectAdapter>(
                  builder: (context, subjectAdapter,child) => subjectAdapter.ended == false
                      ? const LoadingIndicator()
                      : ListView.builder(
                      itemCount: subjectAdapter.subjects.length ?? 0,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) =>
                          SubjectItem(subject: subjectAdapter.subjects[index], function: "-", currloggedInUser: loggedInUser, subjectAdapter: subjectAdapter,)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

