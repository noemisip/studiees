import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:stud_iees/entities/user.dart';

class UserDao extends ChangeNotifier {
  late List<User> users = [];
  final _userRef = FirebaseDatabase.instance.reference().child('user/');

  void createUser(User user) {
    _userRef.child(user.name).set(user.toJson()).catchError((e) {
      print(e);
    }).then((value) {
      print("ok");
    });
  }
}
