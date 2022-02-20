import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../app_router.dart';
import '../colors.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: MyColors.background1), //leading: Image.asset(Images.pngImgPath('sun'))),
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
                      onPressed: () {},
                    ),
                    const Text("/", style: TextStyle(color: Colors.white)),
                    CupertinoButton(
                      child: Text(
                        tr("hu"),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      onPressed: () {},
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
                          padding: EdgeInsets.only(left: 5),
                          child: Text(tr("username"),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            hintText: "Username",
                            fillColor: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(tr("password"),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            hintText: "Password",
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: CupertinoButton(
                        child: Text(
                          tr("login"),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        color: Colors.white,
                        onPressed: () {





                        },
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    Text(tr("or"),
                        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.all(20),
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
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}