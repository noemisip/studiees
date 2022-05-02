
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stud_iees/adapter/quiz_adapter.dart';
import 'package:stud_iees/adapter/subject_adapter.dart';
import 'package:stud_iees/entities/question.dart';
import 'adapter/grade_adapter.dart';
import 'adapter/question_adapter.dart';
import 'adapter/semester_adapter.dart';
import 'adapter/user_adapter.dart';
import 'firebase_options.dart';
import 'app_router.dart';
import 'colors.dart';
import 'package:provider/provider.dart';


String initScreen = "/";
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EasyLocalization(
      path: "lib/assets/langs",
      useOnlyLangCode: true,
      supportedLocales: const [
        Locale('en'),
        Locale('hu'),
      ],
      child: MyApp()));

  initScreen =  AppRouter.login;
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SubjectAdapter>(create: (_) => SubjectAdapter()),
        ChangeNotifierProvider<UserAdapter>(create: (_) => UserAdapter()),
        ChangeNotifierProvider<SemesterAdapter>(create: (_) => SemesterAdapter()),
        ChangeNotifierProvider<QuizAdapter>(create: (_) => QuizAdapter()),
        ChangeNotifierProvider<QuestionAdapter>(create: (_) => QuestionAdapter()),
        ChangeNotifierProvider<GradeAdapter>(create: (_) => GradeAdapter()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: MyColors.background1
          ),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'app',
        initialRoute: initScreen,
        onGenerateRoute: AppRouter.generator,
      ),
    );
  }
}


