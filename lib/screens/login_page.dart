
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/helpers/picturehelper.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;
  var email = TextEditingController();
  var password = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: MyColors.background1, title: Container(
          alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: 50,
            child: IntrinsicWidth(child: Image.asset(Images.pngImgPath('sun'))))),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [MyColors.background1, MyColors.background2])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: Text(
                        tr("en"),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      onPressed: () {
                        context.locale = Locale('en');
                      },
                    ),
                    const Text("/", style: TextStyle(color: Colors.white)),
                    CupertinoButton(
                      child: Text(
                        tr("hu"),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(tr("login"),
                                style: const TextStyle(
                                    fontSize: 30, color: Colors.white, fontWeight: FontWeight.w700))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(tr("email"),
                              style:
                                 const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
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
                              style:
                                  const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
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
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          signIn(email.text, password.text);
                        },
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        borderRadius: BorderRadius.all(const Radius.circular(20)),
                      ),
                    ),
                    Text(tr("or"),
                        style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: CupertinoButton(
                        child: Text(
                          tr("register"),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
        ));
  }

  void signIn(String email, String password) async {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
        Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.home, (route) => false)
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
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
        print(error.code);
      }
    }


}
