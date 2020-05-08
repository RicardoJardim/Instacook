import 'package:flutter/material.dart';
import 'package:instacook/perfil/change_perfil.dart';
import 'package:instacook/receitas/see_recipe.dart';
import '../router.dart';
import '../main.dart';

class MainPerfil extends StatefulWidget {
  MainPerfil({Key key}) : super(key: key);

  _MainPerfilState createState() => _MainPerfilState();
}

class _MainPerfilState extends State<MainPerfil> {
  static Map getLista2() {
    var profile = new Map<String, dynamic>();

    profile = {
      "id": 1,
      "username": "Diana C. Faria",
      "pro": false,
      "photo": 'https://picsum.photos/250?image=9',
      "email": "dciasojd@hotmail.com",
      "recipes": ["1", "2", "3", "4", "5"],
      "follow": 28,
      "followers": 44
    };
    return profile;
  }

  void initState() {
    profile = getLista2();
    super.initState();
  }

  void save() {
    print("send profile");

    print(profile);
  }

  static Map<String, dynamic> profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  height: 100.0,
                  child: DrawerHeader(
                    child: Text(profile["username"],
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
                  main_key.currentState.push(
                      MaterialPageRoute(builder: (context) => ChangeProfile()));
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
                  main_key.currentState
                      .popUntil((r) => r.settings.name == Routes.login);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Center(
                          child: Column(
                        children: <Widget>[
                          Container(
                              height: 120,
                              width: 130,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.network(
                                        profile["photo"],
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: progress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? progress
                                                          .cumulativeBytesLoaded /
                                                      progress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      )),
                                ),
                                profile["pro"]
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(
                                          Icons.brightness_5,
                                          color: Colors.blue,
                                          size: 36,
                                        ))
                                    : Text("")
                              ])),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              profile["username"],
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
                                Text(profile["followers"].toString() +
                                    " seguidores"),
                                Text(" - "),
                                Text(profile["follow"].toString() + " a seguir")
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GridList(
                        litems: profile["recipes"],
                      ),
                    ),
                  ],
                ))));
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
  void seeRecipe(String id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
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
                child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      seeRecipe(widget.litems[index]);
                    },
                    child: Center(child: Text(widget.litems[index]))),
              ),
            );
          });
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento receitas criadas",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
