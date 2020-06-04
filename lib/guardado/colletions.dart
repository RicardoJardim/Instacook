import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/savedService.dart';
import 'package:instacook/services/userService.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'edit_collection.dart';

class Colletions extends StatefulWidget {
  Colletions({Key key, this.onPop, this.id}) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final int id;
  _ColletionsState createState() => _ColletionsState();
}

class _ColletionsState extends State<Colletions> {
  final _auth = AuthService();
  final _savedService = SavedService();
  final _userService = UserService();

  Future<String> getSingleColletion() async {
    String _id = await _auth.getCurrentUser();
    return await _userService.getMyID(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  main_key.currentState.push(MaterialPageRoute(
                      builder: (context) => EditCollection(id: widget.id)));
                }),
          ],
        ),
        body: FutureBuilder(
            future: getSingleColletion(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return SafeArea(
                    top: true,
                    child: StreamProvider<DocumentSnapshot>.value(
                        value: _savedService.getSingleBook(snapshots.data),
                        builder: (context, snapshot) {
                          return _mainWidget(
                              litems: Provider.of<DocumentSnapshot>(context) ??
                                  null,
                              id: widget.id);
                        }));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget _mainWidget({litems, id}) {
    if (litems != null) {
      Map _map = litems.data["recipesBook"]
          .firstWhere((element) => element["id"] == id, orElse: () => null);

      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 60, left: 15),
                    child: Text(
                      _map["name"],
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextField(
                      style: TextStyle(
                          fontSize: 16.0, height: 0.7, color: Colors.black),
                      onChanged: (text) {
                        print("Pesquisa: $text");
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GridList(
                  litems: _map["recipes"],
                ),
              )
            ],
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
    this.litems,
  }) : super(key: key);

  List litems;
  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  final _recipeService = RecipeService();
  void seeRecipe(String id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
            )));
  }

  Future<Recipe> getUser(String id) async {
    var reci = await _recipeService.getSingleRecipeSmall(id);
    return reci;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.litems);
    if (widget.litems.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: widget.litems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.88),
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: getUser(widget.litems[index]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                                  seeRecipe(snapshot.data.id);
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 140,
                                        width: 300,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            snapshot.data.imgUrl,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 2),
                                        child: Text(
                                          snapshot.data.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 2),
                                        child: Text(
                                          snapshot.data.time +
                                              " - " +
                                              snapshot.data.difficulty,
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
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          });
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento receitas guardadas",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
