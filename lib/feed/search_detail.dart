import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/userService.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Details extends StatefulWidget {
  Details({
    Key key,
    this.onPop,
    this.id,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final String id;
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _recipeService = RecipeService();
  final _userService = UserService();
  final _auth = AuthService();

  bool switch1 = false;
  bool switch2 = false;

  Future<String> getUserId() async {
    var myId = await _userService.getMyID(await _auth.getCurrentUser());

    return myId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  height: 100.0,
                  child: DrawerHeader(
                    child: Text(widget.id,
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
                    Text('Filter 1',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Switch(
                      value: switch1,
                      onChanged: (value) {
                        setState(() {
                          switch1 = value;
                        });
                      },
                      activeTrackColor: Colors.amber[200],
                      activeColor: Colors.amber[800],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filter 2',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Switch(
                        value: switch2,
                        onChanged: (value) {
                          setState(() {
                            switch2 = value;
                          });
                        },
                        activeTrackColor: Colors.amber[200],
                        activeColor: Colors.amber[800],
                      ),
                    ]),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 50,
            ),
            onPressed: () => widget.onPop(context),
          ),
          actions: <Widget>[
            // action button
            IconButton(
                padding: EdgeInsets.only(right: 15, top: 5),
                icon: Icon(
                  Icons.tune,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  scaffoldKey.currentState.openEndDrawer();
                }),
            // action button
            // overflow menu
          ],
        ),
        body: FutureBuilder(
            future: getUserId(),
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
                                      right: 60, left: 15),
                                  child: Text(
                                    widget.id,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 8.0, right: 8.0),
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
                              padding: const EdgeInsets.only(top: 30),
                              child: StreamProvider<List<Recipe>>.value(
                                  value: _recipeService.getRecipes(
                                      "type", widget.id),
                                  builder: (context, snapshot) {
                                    return GridList(
                                        litems: Provider.of<List<Recipe>>(
                                                context) ??
                                            [],
                                        myId: snapshots.data);
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
//GRID VIEW

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({Key key, this.litems, this.myId}) : super(key: key);

  List litems;
  final String myId;
  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  //double itemHeight = 8.0;

  void seeRecipe(String id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    widget.litems.removeWhere((element) => element.userId == widget.myId);
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
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        seeRecipe(widget.litems[index].id);
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
                                    widget.litems[index].imgUrl,
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
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 2),
                              child: Text(
                                widget.litems[index].name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 2),
                              child: Text(
                                widget.litems[index].time.toString() +
                                    " - " +
                                    widget.litems[index].difficulty.toString(),
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
  }
}
