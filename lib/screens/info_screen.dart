import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/widget/loading_indicator.dart';
import '../adapter/user_adapter.dart';
import '../colors.dart';
import '../entities/user.dart';
import '../widget/my_text.dart';
import '../widget/rounded_shadow_view.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  UserAdapter userAdapter = UserAdapter();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
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
                userAdapter.logout(context);
              },
              child: const Icon(Icons.logout, color: Colors.white,))),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [MyColors.background1, MyColors.background2])),
        child: loggedInUser.role == null? LoadingIndicator() : Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: MyText(
                      text: loggedInUser.role! ? tr("teacher") : tr("student"),
                      fontweight: FontWeight.w800, fontsize: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: RoundedShadowView(
                  backgroundColor: MyColors.tabBarColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: tr("name"), fontweight: FontWeight.bold,),
                            MyText(text: loggedInUser.name ?? "" ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: tr("username"), fontweight: FontWeight.bold,),
                            MyText(text: loggedInUser.username ?? "" ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: tr("email"), fontweight: FontWeight.bold,),
                            MyText(text: loggedInUser.email ?? "" ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: tr("birthday"), fontweight: FontWeight.bold,),
                            MyText(text: formatter.format(DateTime.fromMillisecondsSinceEpoch(loggedInUser.birthdate?? 0)).toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(text: tr("university"), fontweight: FontWeight.bold,),
                            MyText(text: loggedInUser.university?? "" ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
