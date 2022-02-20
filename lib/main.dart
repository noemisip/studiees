import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_router.dart';


String initScreen = "/";
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'app',
      initialRoute: initScreen,
      onGenerateRoute: AppRouter.generator,
    );
  }
}

