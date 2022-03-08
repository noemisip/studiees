import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/helpers/picturehelper.dart';
import 'package:stud_iees/widget/my_dialog.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../entities/user.dart';
import '../widget/my_date.dart';
import '../adapter/user_adapter.dart';
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

class _RegisterPageState extends State<MyStatefulWidget> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  UserModel userModel = UserModel();
  UserAdapter userAdapter = UserAdapter();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var university = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var birthdate = SelectedDate();
  bool role = false;

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
            resizeToAvoidBottomInset: false,
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
                        padding: const  EdgeInsets.only(left: 5),
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
                    child: TextFormField(
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
                            borderSide: BorderSide(
                                color: MyColors.background1, width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          hintText: tr("firstname"),
                          fillColor: Colors.white),
                      onSaved: (value) {
                        firstname.text = value!;
                      },
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
                    child: TextFormField(
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
                              borderSide: BorderSide(
                                  color: MyColors.background1, width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            hintText: tr("lastname"),
                            fillColor: Colors.white),
                        onSaved: (value) {
                          lastname.text = value!;
                        }),
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
                    child: TextFormField(
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
                              borderSide: BorderSide(
                                  color: MyColors.background1, width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            hintText: tr("username"),
                            fillColor: Colors.white),
                        onSaved: (value) {
                          username.text = value!;
                        }),
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
                    child: TextFormField(
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
                              borderSide: BorderSide(
                                  color: MyColors.background1, width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            hintText: tr("password"),
                            fillColor: Colors.white),
                        onSaved: (value) {
                          password.text = value!;
                        }),
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
                    child: TextFormField(
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
                              borderSide: BorderSide(
                                  color: MyColors.background1, width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            hintText: tr("email"),
                            fillColor: Colors.white),
                        onSaved: (value) {
                          email.text = value!;
                        }),
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
                    child: TextFormField(
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
                              borderSide: BorderSide(
                                  color: MyColors.background1, width: 2.0),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            filled: true,
                            hintText: tr("university"),
                            fillColor: Colors.white),
                        onSaved: (value) {
                          university.text = value!;
                        }),
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

                        userModel.username = username.text;
                        userModel.name = firstname.text + " " + lastname.text;
                        userModel.email = email.text;
                        userModel.role = role;
                        userModel.university = university.text;
                        userModel.birthdate = birthdate.selectedDate.millisecondsSinceEpoch;
                        userModel.password = password.text;

                        signUp(email.text, password.text, userModel);
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

  void signUp(String email, String password, UserModel userModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {userAdapter.postDetailsToFirestore(context,userModel)});
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          errorMessage = "Password should be at least 6 characters";
              break;
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
     showErrorMessage(context, errorMessage!);
      print(e);
    }
  }
}
