
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/helpers/picturehelper.dart';
import '../adapter/user_adapter.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '../entities/user.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var email = TextEditingController();
  var password = TextEditingController();
  UserAdapter userAdapter = UserAdapter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: Text(
                      tr("en"),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {
                      context.locale = Locale('en');
                    },
                  ),
                  const Text("/", style: TextStyle(color: Colors.white)),
                  CupertinoButton(
                    child: Text(
                      tr("hu"),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {
                      context.locale = const Locale('hu');
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.pngImgPath('sun')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(tr("login"),
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.background1, width: 2.0),
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
                          hintText: tr("email"),
                          fillColor: Colors.white),
                      onSaved: (value) {
                        email.text = value!;
                      },
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
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.background1, width: 2.0),
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
                          hintText: tr("password"),
                          fillColor: Colors.white),
                      onSaved: (value) {
                        password.text = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoButton(
                      child: Text(
                        tr("login"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      color: Colors.white,
                      onPressed: () {
                       userAdapter.signIn(email.text, password.text,context);
                      },
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      borderRadius: BorderRadius.all(const Radius.circular(20)),
                    ),
                  ),
                  Text(tr("or"),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
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
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouter.register, (route) => false);
                      },
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      borderRadius: BorderRadius.all(const Radius.circular(20)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

}
