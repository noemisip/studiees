import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../app_router.dart';
import '../entities/user.dart';
import '../widget/my_dialog.dart';

class UserAdapter extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  List<UserModel> users = [];
  late UserModel currentUser;

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

  postDetailsToFirestore(BuildContext context, UserModel userModel) async {
    User? user = _auth.currentUser;

    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
  }

  Future getUserById(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      UserModel loggedInUser = UserModel();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
      });
      currentUser = loggedInUser;
    }
    notifyListeners();
  }

  void changeCurrentSemester(UserModel user, BuildContext context){
    FirebaseFirestore.instance.collection("Users").doc(user.uid).update(
      user.toMap()
    );
   // getUserById(context);
    notifyListeners();
  }

  void signIn(String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => getUserById(context))
          .then((uid) {
        if (currentUser.role == true) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.teacher_home, (route) => false);
        }
        else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.student_home, (route) => false);
        }
      });
    } on FirebaseAuthException catch (error) {
      chooseErrorMessage(error.code);
      showErrorMessage(context, errorMessage!);
      print(error.code);
    }
  }

  void signUp(String email, String password, UserModel userModel,
      BuildContext context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(context, userModel)});
    } on FirebaseAuthException catch (error) {
      chooseErrorMessage(error.code);
      showErrorMessage(context, errorMessage!);
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().whenComplete(() =>
        Navigator.of(context, rootNavigator: true)
            .pushNamedAndRemoveUntil(AppRouter.login, (route) => false));
  }

  String? chooseErrorMessage( String error){
    switch(error){
      case "invalid-email":
        errorMessage = tr("invalid-email");
        return errorMessage;
      case "wrong-password":
        errorMessage = tr("wrong-password");
        return errorMessage;
      case "user-not-found":
        errorMessage = tr("user-not-found");
        return errorMessage;
      case "user-disabled":
        errorMessage = tr("user-disabled");
        return errorMessage;
      case "too-many-requests":
        errorMessage = tr("undefined-error");
        return errorMessage;
      case "operation-not-allowed":
        errorMessage = tr("undefined-error");
        return errorMessage;
      default:
        errorMessage = tr("undefined-error");
        return errorMessage;
    }
  }
}
