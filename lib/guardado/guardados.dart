import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/savedService.dart';
import 'package:instacook/services/userService.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../router.dart';

class MainGuardado extends StatefulWidget {
  MainGuardado({
    Key key,
    this.onPush,
  }) : super(key: key);

  final ValueChanged<Map<String, dynamic>> onPush;

  _MainGuardadoState createState() => _MainGuardadoState();
}

class _MainGuardadoState extends State<MainGuardado> {
  final _auth = AuthService();
  final _savedService = SavedService();
  final _userService = UserService();

  Future<String> getMyUserID() async {
    String _id = await _auth.getCurrentUser();

    return await _userService.getMyID(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getMyUserID(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return SafeArea(
                    top: true,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 60, left: 15),
                                  child: Text(
                                    "Receitas Guardadas",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        height: 0.7,
                                        color: Colors.black),
                                    onChanged: (text) {
                                      print("Pesquisa: $text");
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                      ),
                                      hintText: 'Enter a search term',
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: StreamProvider<DocumentSnapshot>.value(
                                  value: _savedService.getBooks(snapshots.data),
                                  builder: (context, snapshot) {
                                    return SwipeList(
                                      litems: Provider.of<DocumentSnapshot>(
                                              context) ??
                                          null,
                                      onPush: widget.onPush,
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: StreamProvider<List<Recipe>>.value(
                                  value: _savedService.getSavedRecipes(
                                      snapshots.data, 10),
                                  builder: (context, snapshot) {
                                    return GridList(
                                      savedService:
                                          Provider.of<List<Recipe>>(context) ??
                                              [],
                                    );
                                  }),
                            )
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
class SwipeList extends StatefulWidget {
  SwipeList({Key key, this.litems, this.onPush}) : super(key: key);

  DocumentSnapshot litems;

  final ValueChanged<Map<String, dynamic>> onPush;
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  List list;
  @override
  Widget build(BuildContext context) {
    if (widget.litems != null) {
      list = widget.litems.data["recipesBook"];
      list.insert(0, {"name": "Novo Livro"});
      return Container(
          height: 120.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border:
                                Border.all(color: Colors.amber[900], width: 2)),
                        margin: EdgeInsets.only(right: 10.0, left: 10),
                        child: InkWell(
                            enableFeedback: true,
                            splashColor: Colors.amber[900],
                            onTap: () {
                              Map<String, dynamic> data = ({
                                "route": TabRouterSaved.create,
                              });
                              widget.onPush(data);
                            },
                            borderRadius: BorderRadius.circular(200),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.amber[900],
                              ),
                            ))),
                    Container(
                      width: 100,
                      child: Text(
                        list[index]["name"],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    )
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                              image: NetworkImage(list[index]["imgUrl"]),
                              fit: BoxFit.fitHeight),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.amber[900], width: 2)),
                      margin: EdgeInsets.only(right: 10.0, left: 10),
                      child: InkWell(
                        enableFeedback: true,
                        splashColor: Colors.amber[900],
                        onTap: () {
                          Map<String, dynamic> data = ({
                            "route": TabRouterSaved.saved,
                            "id": list[index]["id"],
                          });

                          widget.onPush(data);
                        },
                        borderRadius: BorderRadius.circular(200),
                      )),
                  Container(
                    width: 100,
                    child: Text(
                      list[index]["name"],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  )
                ],
              );
            },
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

//GRID VIEW

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({
    Key key,
    this.savedService,
  }) : super(key: key);

  final List<Recipe> savedService;
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
    if (widget.savedService != null || widget.savedService.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: widget.savedService.length,
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
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          seeRecipe(widget.savedService[index].id);
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 140,
                                width: 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.savedService[index].imgUrl,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: progress.expectedTotalBytes !=
                                                  null
                                              ? progress.cumulativeBytesLoaded /
                                                  progress.expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  widget.savedService[index].name,
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
                                  widget.savedService[index].time +
                                      " - " +
                                      widget.savedService[index].difficulty,
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
