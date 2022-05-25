import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import 'package:stud_iees/screens/selected_subject_page.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import 'package:stud_iees/widget/my_picker_semester.dart';
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

class _SubjectPageState extends State<SubjectPage> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserAdapter userAdapter = UserAdapter();

  @override
  initState() {
    super.initState();
    userAdapter = context.read<UserAdapter>();
    subjectAdapter = context.read<SubjectAdapter>();
    userAdapter.getCurrentUser(context).whenComplete(() {
      loggedInUser = userAdapter.currentUser;
      setState(() {
        if (loggedInUser.role == true) {
          subjectAdapter.getSubjectsById(loggedInUser.uid!);
        } else if (loggedInUser.role == false) {
          subjectAdapter.getSubjectsByUniversity(loggedInUser);
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
        child: Column(
          children: [
            MyPicker("", signedUp: false, all: true),
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Consumer<SubjectAdapter>(
                  builder: (context, subjectAdapter, child) =>
                      subjectAdapter.ended == false
                          ? const LoadingIndicator()
                          : ListView.builder(
                              itemCount: subjectAdapter.subjects.length,
                              padding: const EdgeInsets.all(20),
                              itemBuilder: (context, index) => SubjectItem(
                                    subject: subjectAdapter.subjects[index],
                                    function: "+",
                                    currLoggedInUser: loggedInUser,
                                    subjectAdapter: subjectAdapter,
                                  )),
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
  const SubjectItem(
      {Key? key,
      required this.currLoggedInUser,
      required this.subject,
      required this.function,
      required this.subjectAdapter})
      : super(key: key);

  final SubjectModel subject;
  final String function;
  final UserModel currLoggedInUser;
  final SubjectAdapter subjectAdapter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) =>
                SelectedSubject(selectedSubject: subject, function: function));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RoundedShadowView(
          backgroundColor: MyColors.tabBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: MyText(text: subject.name ?? "")),
              MyText(text: subject.credit.toString() + " " + tr("credit")),
              MyText(
                  text: subject.currentPart.toString() +
                      "/" +
                      subject.limit.toString()),
              if (currLoggedInUser.role == false)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CupertinoButton(
                        child: Text(
                          function,
                          style: TextStyle(
                              color: MyColors.background1,
                              fontWeight: FontWeight.w600),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          if (function == "+") {
                            subjectAdapter.signUpSubject(subject, context);
                          }
                          if (function == "-") {
                            subjectAdapter.signDownSubject(subject, context);
                          }
                        },
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
