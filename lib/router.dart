class Routes {
  static const String login = '/';
  static const String register = '/register';
  static const String mainapp = '/main';
  static const String search = '/search';
}

class TabRouterFeed {
  static const String root = '/';
  static const String search = "/search";
  static const String details = "/details";
  static const String people = "/people";
}

class TabRouterSaved {
  static const String root = '/';
  static const String saved = "/saved";
}

//Navega para o widget SignUpPage() e adiciona à stack
/* Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())); */

// Vai para o anterior e retira da stack
/* Navigator.pop(context); */

// Navega para a route mainapp a qu esta associado um widget no main.dart
/*  Navigator.pushNamed(context, Routes.mainapp); */

// Vai até ao login retirando todos da stack
/* Navigator.popUntil(context, (r) => r.settings.name == Routes.login); */

// Retira ele propio da stack e mete outro
/* Navigator.popAndPushNamed(context, Routes.mainapp); */

// Retira ele propio da stack e faz replace por outro
/* Navigator.pushReplacementNamed(context, Routes.register); */

// Retira ele propio e outros até o x da stack e mete outro
/* Navigator.pushNamedAndRemoveUntil(context, Routes.register, (r) => r.settings.name == Routes.login) */
