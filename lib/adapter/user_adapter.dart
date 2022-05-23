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
  List<String> subjects = [];
   UserModel subjTeacher = UserModel();
   bool loading = false;

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

  Future<void> getCurrentUser(BuildContext context) async {
    loading = false;
    User? user =  _auth.currentUser;
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
    loading = true;
  }

  Future<void> getTeacherById( String tid,BuildContext context) async{
    await firebaseFirestore.collection("Users").where("uid", isEqualTo: tid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
      subjTeacher = UserModel.fromMap(result);
      });
    });
    notifyListeners();
  }

  void changeCurrentSemester(UserModel user, BuildContext context){
    FirebaseFirestore.instance.collection("Users").doc(user.uid).update(
      user.toMap()
    );
    notifyListeners();
  }

  Future<void> addSubjectToUser(UserModel user, String sid, BuildContext context) async{
    subjects.add(sid);
    user.subjects?.add(sid);
    await firebaseFirestore.collection("Users").doc(user.uid).update({"subjects": FieldValue.arrayUnion(subjects)});
    notifyListeners();
  }

  Future<void> removeSubjectFromUser(UserModel user, String sid, BuildContext context) async{
    subjects.remove(sid);
    user.subjects?.remove(sid);
    List<String> removeable = [];
    removeable.add(sid);
    await firebaseFirestore.collection("Users").doc(user.uid).update({
      'subjects': FieldValue.arrayRemove(removeable)});
    notifyListeners();
    print(subjects);
  }

  void signIn(String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => getCurrentUser(context))
          .then((uid) {
        if( currentUser.admin == true)
        {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.admin, (route) => false);
        } else
        if (currentUser.role == true) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.teacher_home, (route) => false);
        } else
        if (currentUser.role == false) {
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
