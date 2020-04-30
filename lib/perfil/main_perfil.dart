import 'package:flutter/material.dart';
import '../router.dart';

class MainPerfil extends StatefulWidget {
  _MainPerfilState createState() => _MainPerfilState();
}

class _MainPerfilState extends State<MainPerfil> {
  static int seguidores = 44;
  static int aseguir = 28;
  static bool pro = false;
  static String name = "Diana C. Faria";
  static List onSomeEvent() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  height: 100.0,
                  child: DrawerHeader(
                    child: Text("$name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    decoration: BoxDecoration(
                      color: Colors.amber[800],
                    ),
                  )),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Editar Perfil',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Icon(Icons.settings),
                  ],
                ),
                subtitle: Text('Edita aqui o seu perfil'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logout',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Icon(Icons.forward),
                    ]),
                subtitle: Text('Terminar a sua sessão'),
                onTap: () {
                  Navigator.popUntil(
                      context, (r) => r.settings.name == Routes.login);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Container(
                          height: 110,
                          width: 120,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    'https://picsum.photos/250?image=9',
                                  )),
                            ),
                            pro
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.beenhere,
                                      color: Colors.blue,
                                      size: 36,
                                    ))
                                : Text("")
                          ])),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "$name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("$seguidores seguidores"),
                            Text(" - "),
                            Text("$aseguir a seguir")
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GridList(
                    litems: onSomeEvent(),
                  ),
                ),
              ],
            )));
  }
}

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({
    Key key,
    this.litems,
  }) : super(key: key);

  final List litems;
  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  var first = false;

  double itemHeight(int index) {
    if (!first) {
      if (index % 2 == 0) {
        return 8.0;
      } else {
        first = true;
        return 50.0;
      }
    } else {
      return 8.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.litems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.only(bottom: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Colors.blue,
              elevation: 10,
              child: Center(child: Text(widget.litems[index])),
            ),
          );
        });
  }
}
