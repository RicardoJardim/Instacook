import 'package:flutter/material.dart';
import 'package:instacook/receita/search_detail.dart';
import 'feed.dart';
import 'search.dart';
import 'search_detail.dart';
import '../router.dart';

class TabNavigatorFeed extends StatelessWidget {
  void _push(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabRouterFeed.search](context),
      ),
    );
  }

  void _pushNext(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabRouterFeed.details](context),
      ),
    );
  }

  void _pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabRouterFeed.root: (context) => MainReceita(
            onPush: (context) => _push(context),
          ),
      TabRouterFeed.search: (context) => Search(
            onPop: (context) => _pop(context),
            onPush: (context) => _pushNext(context),
          ),
      TabRouterFeed.details: (context) => Details(
            onPop: (context) => _pop(context),
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      initialRoute: TabRouterFeed.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
