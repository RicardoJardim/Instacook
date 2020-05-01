import 'package:flutter/material.dart';
import 'package:instacook/feed/search_detail.dart';
import 'feed.dart';
import 'search.dart';
import 'search_detail.dart';
import '../router.dart';

class TabNavigatorFeed extends StatelessWidget {
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
      TabRouterFeed.root: (context) => MainReceita(
            onPush: (data) => _push(context, data),
          ),
      TabRouterFeed.search: (context) => Search(
            onPop: (context) => _pop(context),
            onPush: (data) => _push(context, data),
          ),
      TabRouterFeed.details: (context) => Details(
            onPop: (context) => _pop(context),
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context, data);
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
