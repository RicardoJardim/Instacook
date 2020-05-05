import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../perfil/main_perfil.dart';
import '../feed/main.dart';
import '../compras/main_compras.dart';
import '../guardado/main.dart';
import '../router.dart';
import '../receitas/see_recipe.dart';

class BottomlWidget extends StatefulWidget {
  BottomlWidget({Key key, this.onPush, this.onPopUntil}) : super(key: key);

  ValueChanged<Map<String, dynamic>> onPush;
  ValueChanged<Map<String, dynamic>> onPopUntil;

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomlWidget> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    TabNavigatorFeed(),
    TabNavigatorSaved(),
    MainCompras(),
    MainPerfil(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var verifyDrag = false;
  var left = false;

  //WillPopScope impede de ir para tras
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                __buildItem('Receitas', Icons.local_dining),
                __buildItem('Guardado', Icons.bookmark),
                __buildItem('Compras', Icons.event_available),
                __buildItem('Perfil', Icons.account_box),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              selectedIconTheme: IconThemeData(size: 30),
              onTap: _onItemTapped,
              showUnselectedLabels: true,
              unselectedItemColor: Colors.grey,
            ),
          ),
        ));
  }

  BottomNavigationBarItem __buildItem(String title, IconData icons) {
    return BottomNavigationBarItem(
      icon: Icon(icons),
      title: Text(title),
    );
  }
}
