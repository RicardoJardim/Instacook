import 'package:flutter/material.dart';
import 'package:instacook/guardado/create_colletion.dart';
import 'guardados.dart';
import 'colletions.dart';
import '../router.dart';

final GlobalKey<NavigatorState> saved_key = GlobalKey();

class TabNavigatorSaved extends StatelessWidget {
  Map<String, dynamic> data = new Map<String, dynamic>();

  void _push(BuildContext context, Map<String, dynamic> data) {
    var routeBuilders = _routeBuilders(context, data);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[data["route"]](context),
      ),
    );
  }

  void _pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(
      BuildContext context, Map<String, dynamic> data) {
    return {
      TabRouterSaved.root: (context) => MainGuardado(
            onPush: (data) => _push(context, data),
          ),
      TabRouterSaved.saved: (context) => Colletions(
            onPop: (context) => _pop(context),
            colletionName: data["title"],
            id: data["id"],
          ),
      TabRouterSaved.create: (context) =>
          CreateColletion(onPop: (context) => _pop(context)),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, data);
    return Navigator(
      key: saved_key,
      initialRoute: TabRouterSaved.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
