import 'package:flutter/material.dart';
import 'package:instacook/receitas/see_recipe.dart';

import 'login_register/login.dart';
import 'login_register/signup.dart';
import 'bottombar/bottom.dart';
import 'router.dart';

void main() => runApp(MyApp());

final GlobalKey<NavigatorState> main_key = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
      ),
      initialRoute: Routes.login,
      routes: {
        Routes.login: (BuildContext context) => LoginPage(),
        Routes.register: (BuildContext context) => SignUpPage(),
        Routes.mainapp: (BuildContext context) => BottomlWidget(),
      },
      navigatorKey: main_key,
    );
  }
}
