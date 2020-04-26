import 'package:flutter/material.dart';
import 'perfil/main_perfil.dart';
import 'receita/main_receita.dart';
import 'compras/main_compras.dart';
import 'guardado/main_guardado.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      theme: ThemeData(
        primaryColor: Colors.amber[800],
      ),
      //darkTheme: ,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    MainReceita(),
    MainGuardado(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_dining),
              title: Text('Receitas'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              title: Text('Guardado'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Compras'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          selectedIconTheme: IconThemeData(size: 30),
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey),
    );
  }
}

/*

 child: GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              print(details.localPosition.dy);
              if (details.localPosition.dy >= 250) verifyDrag = true;
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (verifyDrag) {
                if (details.primaryDelta >= 3 && _selectedIndex != 0) {
                  left = true;
                } else if (details.primaryDelta <= -3 && _selectedIndex != 3) {
                  left = false;
                }
              }
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (left == true && _selectedIndex != 0) {
                _selectedIndex--;
                _onItemTapped(_selectedIndex);
              } else if (left == false && _selectedIndex != 3) {
                _selectedIndex++;
                _onItemTapped(_selectedIndex);
              }
              verifyDrag = false;
            },
            child: _widgetOptions.elementAt(_selectedIndex)),

            */
