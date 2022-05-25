import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/adapter/user_adapter.dart';
import '../../adapter/semester_adapter.dart';
import '../../colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../entities/semester.dart';
import '../../entities/user.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  var startYear = TextEditingController();
  var endYear = TextEditingController();
  var number = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? errorMessage;
  SubjectAdapter subjectAdapter = SubjectAdapter();
  UserAdapter userAdapter = UserAdapter();
  SemesterAdapter semesterAdapter = SemesterAdapter();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
            backgroundColor: MyColors.background1,
            centerTitle: true,
            title: Text(tr('admin_page'),
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
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text(tr("add_new_semester"),
                                style:
                                const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: startYear,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    fillColor: Colors.white),
                                onSaved: (value) {
                                  startYear.text = value!;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5,right: 5),
                              child: Text("/",
                                  style:
                                  TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              width: 100,
                              child: TextFormField(
                                controller: endYear,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    fillColor: Colors.white),
                                onSaved: (value) {
                                  endYear.text = value!;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5,right: 5),
                              child: Text("/",
                                  style:
                                  TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              width: 50,
                              child: TextFormField(
                                controller: number,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    fillColor: Colors.white),
                                onSaved: (value) {
                                  number.text = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CupertinoButton(
                          child: const Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          color: MyColors.tabBarColor,
                          onPressed: () {
                            SemesterModel newSemester = SemesterModel(
                                semester: startYear.text + "/" + endYear.text + "/" + number.text);
                            semesterAdapter.addSemester(newSemester, context).whenComplete(() {
                              startYear.clear();
                              endYear.clear();
                              number.clear();
                            }
                            );
                          },
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          borderRadius: const BorderRadius.all(const Radius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
