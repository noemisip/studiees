import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import 'package:stud_iees/screens/selected_subject_page.dart';
import 'package:stud_iees/screens/teacher/new_quiz.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import 'package:stud_iees/widget/my_picker.dart';
import 'package:stud_iees/widget/my_text.dart';
import '../adapter/user_adapter.dart';
import '../colors.dart';
import '../entities/user.dart';
import '../widget/rounded_shadow_view.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);


  @override
  _SubjectPageState createState() => _SubjectPageState();
}

UserModel loggedInUser = UserModel();
SubjectAdapter subjectAdapter = SubjectAdapter();
UserAdapter userAdapter = UserAdapter();

class _SubjectPageState extends State<SubjectPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
   initState()  {
    super.initState();
   FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
     setState(() {
     });
      loggedInUser = UserModel.fromMap(value.data());
      subjectAdapter = context.read<SubjectAdapter>();
      if(loggedInUser.role == true){
        subjectAdapter.getSubjectsById(loggedInUser.uid!);
      }
      else if ( loggedInUser.role == false){
        subjectAdapter.getSubjectsByUniversity(loggedInUser);
      }
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
            MyPicker(""),
            Expanded(
              child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Consumer<SubjectAdapter>(
                        builder: (context, subjectAdapter,child) => subjectAdapter.subjects.isEmpty
                            ? const LoadingIndicator()
                            : ListView.builder(
                            itemCount: subjectAdapter.subjects.length ?? 0,
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) =>
                                SubjectItem(subject: subjectAdapter.subjects[index])),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  const SubjectItem({Key? key, required this.subject}) : super(key: key);

  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
          showDialog(context: context, builder: (context) => SelectedSubject());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RoundedShadowView(
          backgroundColor: MyColors.tabBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: MyText(text: subject.name ?? "")),
              MyText(text: subject.credit.toString() +" " + tr("credit")),
              MyText(
                  text: subject.current_part.toString() +
                      "/" +
                      subject.limit.toString()),
              if(loggedInUser.role == false) Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CupertinoButton(
                      child: Text( "+",
                        style: TextStyle(
                            color: MyColors.background1, fontWeight: FontWeight.w600),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        subjectAdapter.signUpSubject(subject, context);
                      },
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
}
