import 'package:flutter/material.dart';

import 'login_register/login.dart';
import 'login_register/signup.dart';
import 'bottombar/bottom.dart';
import 'receita/search.dart';
import 'router.dart';

void main() => runApp(MyApp());

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
        Routes.search: (BuildContext context) => Search(),
      },
    );
  }
}

/*
      home: LoginPage(),

        */
