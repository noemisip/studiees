
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/entities/subject.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../entities/user.dart';


class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final _auth = FirebaseAuth.instance;
  var name = TextEditingController();
  var limit = TextEditingController();
  var credit = TextEditingController();
  var semester = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? errorMessage;
  SubjectAdapter adapter = SubjectAdapter();

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
        appBar: AppBar(backgroundColor: MyColors.background1),
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
                              padding: const EdgeInsets.all(20),
                              child: Text(tr("add_subject"),
                                  style: const TextStyle(
                                      fontSize: 30, color: Colors.white, fontWeight: FontWeight.w700))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("name"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: name,
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
                              hintText: tr("name"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            name.text = value!;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("semester"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: semester,
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
                              hintText: tr("semester"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            semester.text = value!;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("credit"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: credit,
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
                              hintText: tr("credit"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            credit.text = value!;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(tr("limit"),
                                style:
                                const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: TextFormField(
                          controller: limit,
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
                              hintText: tr("limit"),
                              fillColor: Colors.white),
                          onSaved: (value) {
                            limit.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CupertinoButton(
                          child: const Text(
                            "Ok",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            postSubjectToFirestore();
                          },
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          borderRadius: BorderRadius.all(const Radius.circular(20)),
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

  postSubjectToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    SubjectModel subjectModel = SubjectModel();

    subjectModel.credit = int.parse(credit.text);
    subjectModel.limit = int.parse(limit.text);
    subjectModel.tid = loggedInUser.uid;
    subjectModel.name = name.text;
    subjectModel.university = loggedInUser.university;
    subjectModel.current_part = 0;
    subjectModel.semester = semester.text;


    await firebaseFirestore
        .collection("Subjects").doc()
        .set(subjectModel.toMap()).whenComplete(() {
      credit.clear();
      limit.clear();
      name.clear();
      semester.clear();
    }
    );
    adapter.getSubjects();
  }
}
