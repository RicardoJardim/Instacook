import 'package:flutter/material.dart';
import 'guardados.dart';
import 'colletions.dart';
import '../router.dart';

class TabNavigatorSaved extends StatelessWidget {
  void _push(BuildContext context, {String title: "Receitas Guardadas"}) {
    var routeBuilders = _routeBuilders(context, title: title);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabRouterSaved.saved](context),
      ),
    );
  }

  void _pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {String title: "Receitas Guardadas"}) {
    return {
      TabRouterSaved.root: (context) => MainGuardado(
            onPush: (title) => _push(context, title: title),
          ),
      TabRouterSaved.saved: (context) =>
          Colletions(onPop: (context) => _pop(context), colletionName: title),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      initialRoute: TabRouterSaved.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
