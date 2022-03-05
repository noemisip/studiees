
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import 'package:stud_iees/widget/my_text.dart';
import '../app_router.dart';
import '../colors.dart';
import '../helpers/picturehelper.dart';
import '../widget/rounded_shadow_view.dart';


class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {

  SubjectAdapter subjectAdapter = SubjectAdapter();

  @override
  void initState() {
    super.initState();
    subjectAdapter.getSubjects();
    print(subjectAdapter.subjects.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.background1,
          centerTitle: true,
          title: Text(tr('info'),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800)),
          leading: CupertinoButton(
              onPressed: () {
                logout(context);
              },
              child: const Icon(Icons.logout, color: Colors.white,))),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [MyColors.background1, MyColors.background2])),
        child: subjectAdapter.subjects == null? LoadingIndicator() : Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView.builder(
              itemCount: subjectAdapter.subjects.length ?? 0,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) => SubjectItem(subject: subjectAdapter.subjects[index])
        ),
        ),
      ),
    );

  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().whenComplete(() =>  Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil(
        AppRouter.login, (route) => false));
  }
}

class SubjectItem extends StatelessWidget {
  const SubjectItem({Key? key, required this.subject})
      : super(key: key);
  
  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: RoundedShadowView(
        backgroundColor: MyColors.tabBarColor,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             MyText(text: subject.name ?? ""),
             MyText(text: subject.credit.toString() + tr(" credit")),
             MyText(text: subject.current_part.toString() + "/" + subject.limit.toString()),
           ],
         ),
      ),
    );
  }
}

