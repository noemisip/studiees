import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import '../../adapter/user_adapter.dart';
import '../../colors.dart';
import '../../entities/user.dart';
import '../../widget/my_text.dart';
import '../selected_subject_page.dart';


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
  UserAdapter userAdapter = UserAdapter();
  UserModel loggedInUser = UserModel();
  List<String> subjNames = [];
  bool done = false;

  @override
  void initState() {
    super.initState();
    done = false;
    userAdapter = context.read<UserAdapter>();
    subjectAdapter = context.read<SubjectAdapter>();
    userAdapter.getCurrentUser(context).whenComplete((){
      loggedInUser = userAdapter.currentUser;
      subjectAdapter.getAllTasks(loggedInUser);
      subjNames.clear();

      subjectAdapter.quizes.forEach((element) {
        subjectAdapter.getCurrSubjectById(element.subjid!).whenComplete(() {
          subjNames.add(subjectAdapter.currSubj.name!);
          if( subjNames.length == subjectAdapter.quizes.length){
            setState(() {
              done = true;
            });
          }
        });
      });
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
                        builder: (context, subjectAdapter,child) => subjectAdapter.ended == false && userAdapter.loading == false
                            ? const LoadingIndicator()
                            : ListView.builder(
                            itemCount: subjectAdapter.quizes.length,
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (context, index) =>
                                Column(
                                  children: [
                                    SubjItem(name: (done == true)? subjNames[index]: ""),
                                    QuizItem(subjectAdapter,quiz: subjectAdapter.quizes[index], type: loggedInUser.role?? false, user: loggedInUser),
                                  ],
                                )),
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
class SubjItem extends StatelessWidget {
  const SubjItem({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: MyText(fontsize: 17,text: name)),
          ],
        ),
      ],
    );
  }

}

