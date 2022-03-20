import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/screens/admin/admin_page.dart';
import 'package:stud_iees/screens/student/home_page_s.dart';
import 'package:stud_iees/screens/teacher/home_page_t.dart';
import 'package:stud_iees/screens/info_screen.dart';
import 'package:stud_iees/screens/login_page.dart';
import 'package:stud_iees/screens/register_page.dart';


class AppRouter {

  static const initialRoute = "/";
  static const login = "login";
  static const register = "register";
  static const student_home = "studenthome";
  static const teacher_home = "teacherhome";
  static const admin = "admin";

  static Route<dynamic> generator(RouteSettings routeSettings) {

    var path = routeSettings.name;
    var currentPage = path!.split("/").last;
    var pageParameters = currentPage.split("_");

    switch (pageParameters[0]) {
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage(),settings: routeSettings);
      case register:
        return MaterialPageRoute(builder: (context) => const RegisterPage(),settings: routeSettings);
      case teacher_home:
        return MaterialPageRoute(builder: (context) => const TeacherHomeScreen(),settings: routeSettings);
      case student_home:
        return MaterialPageRoute(builder: (context) => const StudentHomeScreen(),settings: routeSettings);
      case admin:
        return MaterialPageRoute(builder: (context) => const AdminPage(),settings: routeSettings);

    }
    throw AssertionError("Path not matched");
  }
}
