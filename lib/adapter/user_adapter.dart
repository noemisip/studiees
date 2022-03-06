import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../app_router.dart';
import '../entities/subject.dart';
import '../entities/user.dart';
import '../widget/my_dialog.dart';

class UserAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  List<UserModel> users = [];

  Future<void> getUsers() async {
    List<UserModel> temp = [];

    await firebaseFirestore.collection("Users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        UserModel model = UserModel.fromMap(result);
        temp.add(model);
      });
    });
    users = temp;
    notifyListeners();
  }

  UserModel getUsersById()  {

    UserModel loggedInUser = UserModel();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser;
  }

  void signIn(String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.teacher_home, (route) => false);
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
      showErrorMessage(context, errorMessage!);
      print(error.code);
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().whenComplete(() =>  Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil(
        AppRouter.login, (route) => false));
  }


}
