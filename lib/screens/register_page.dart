

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stud_iees/helpers/picturehelper.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';


import '../entities/user.dart';
import '../entities/user_dao.dart';
import '../my_date.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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

  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var name = TextEditingController();
  var university = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var birthdate = SelectedDate();
  bool role = false;
  var userDao = UserDao();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUserTest() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'full_name': "Noemi", // John Doe
      'company': "BME", // Stokes and Sons
      'age': 22 // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.background1,
          title: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: 50,
              child:
                  IntrinsicWidth(child: Image.asset(Images.pngImgPath('sun')))),
          leading: CupertinoNavigationBarBackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
            },
          ),
        ), //leading: Image.asset(Images.pngImgPath('sun'))),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColors.background1, MyColors.background2])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(tr("register"),
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(tr("firstname"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: TextField(
                      controller: firstname,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("firstname"),
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("lastname"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: TextField(
                      controller: lastname,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("lastname"),
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("username"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("username"),
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("password"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("password"),
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("email"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("email"),
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("birthday"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: MyDate(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("university"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: TextField(
                      controller: university,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("university"),
                          fillColor: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(tr("role"),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(tr("student"),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                      CupertinoSwitch(
                          value: role,
                          activeColor: MyColors.background1,
                          onChanged: (value) {
                            setState(() {
                              role = value;
                            });
                          }),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(tr("teacher"),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoButton(
                      child: Text(
                        tr("register"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        /*userDao.createUser(User(0,username.text,firstname.text + " " + lastname.text,
                            email.text,password.text,birthdate.selectedDate.millisecondsSinceEpoch,university.text,role));*/
                        addUserTest();
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
