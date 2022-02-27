import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/screens/home_screen.dart';
import 'package:stud_iees/screens/login_page.dart';
import 'package:stud_iees/screens/register_page.dart';


class AppRouter {

  static const initialRoute = "/";
  static const login = "login";
  static const register = "register";
  static const home = "home";

  static Route<dynamic> generator(RouteSettings routeSettings) {

    var path = routeSettings.name;
    var currentPage = path!.split("/").last;
    var pageParameters = currentPage.split("_");

    switch (pageParameters[0]) {
      case login:
        return MaterialPageRoute(builder: (context) =>LoginPage(),settings: routeSettings);
      case register:
        return MaterialPageRoute(builder: (context) => const RegisterPage(),settings: routeSettings);
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage(),settings: routeSettings);

    }
    throw AssertionError("Path not matched");
  }
}
