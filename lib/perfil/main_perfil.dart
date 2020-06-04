import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/models/User.dart';
import 'package:instacook/perfil/change_perfil.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/userService.dart';
import 'package:provider/provider.dart';
import '../router.dart';
import '../main.dart';

class MainPerfil extends StatefulWidget {
  MainPerfil({Key key}) : super(key: key);

  _MainPerfilState createState() => _MainPerfilState();
}

class _MainPerfilState extends State<MainPerfil> {
  final _auth = AuthService();
  final _userService = UserService();
  final _recipeService = RecipeService();

  Future<User> getUser() async {
    var id = await _auth.getCurrentUser();
    var users = await _userService.getMyUser(id);
    return users;
  }

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
                    child: Text("Perfil",
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
                  main_key.currentState.push(MaterialPageRoute(
                      builder: (context) => ChangeProfile(
                            rebuild: () {
                              setState(() {});
                            },
                          )));
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
                onTap: () async {
                  await _auth.signOut();
                  main_key.currentState
                      .popUntil((r) => r.settings.name == Routes.login);
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
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
                                      width: 120,
                                      child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipOval(
                                              child: Image.network(
                                                snapshot.data.imgUrl,
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (context, child, progress) {
                                                  if (progress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
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
                                              ),
                                            ),
                                            snapshot.data.proUser
                                                ? Align(
                                                    alignment:
                                                        Alignment.bottomRight,
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
                                      snapshot.data.username,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(snapshot.data.followers.length
                                            .toString() +
                                        " seguidores - " +
                                        snapshot.data.follow.length.toString() +
                                        " a seguir"),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: StreamProvider<List<Recipe>>.value(
                                  value: _recipeService.getMyRecipes(
                                      "userId", snapshot.data.id),
                                  builder: (context, snapshot) {
                                    return GridList(
                                      litems:
                                          Provider.of<List<Recipe>>(context) ??
                                              [],
                                    );
                                  }),
                            ),
                          ],
                        )));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
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
              goProfile: false,
              mine: true,
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
              crossAxisCount: 2, childAspectRatio: 0.88),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  index % 2 != 1
                      ? SizedBox(
                          height: 0,
                        )
                      : SizedBox(
                          height: 35,
                        ),
                  Container(
                    height: 190,
                    width: 300,
                    child: InkWell(
                        onTap: () {
                          seeRecipe(
                            widget.litems[index].id,
                          );
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  height: 140,
                                  width: 300,
                                  child: Stack(fit: StackFit.expand, children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        widget.litems[index].imgUrl,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
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
                                      ),
                                    ),
                                    widget.litems[index].privacy
                                        ? Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.red)),
                                                child: Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                  size: 24,
                                                )))
                                        : Text("")
                                  ])),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  widget.litems[index].name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  widget.litems[index].time.toString() +
                                      " - " +
                                      widget.litems[index].difficulty
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700]),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ])),
                  ),
                ],
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
