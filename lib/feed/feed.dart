import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/receitas/create/create_recipe.dart';
import 'package:instacook/receitas/save_recipe.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../router.dart';

GlobalKey<ListItemWidget> globalKey = GlobalKey();

class MainReceita extends StatefulWidget {
  MainReceita({
    Key key,
    this.onPush,
  }) : super(key: key);

  final ValueChanged<Map<String, dynamic>> onPush;

  _MainReceitalState createState() => _MainReceitalState();
}

class _MainReceitalState extends State<MainReceita> {
  final _recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
              onTap: () {
                globalKey.currentState.goUp();
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Image.asset(
                  "assets/images/instacook_logo.png",
                  scale: 7,
                ),
              )),
          actions: <Widget>[
            // action button
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Map<String, dynamic> data = new Map<String, dynamic>();
                  data["route"] = TabRouterFeed.search;

                  widget.onPush(data);
                }),
            // action button
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.amber[800],
                size: 30,
              ),
              onPressed: () {
                main_key.currentState.push(
                    MaterialPageRoute(builder: (context) => CreateRecipe()));
              },
            ),
            // overflow menu
          ],
        ),
        body: Center(
            /* child: StreamProvider<List<Map>>.value(
                value: _recipeService.getRecipesAndUser(),
                builder: (context, snapshot) {
                  return SwipeList(
                    key: globalKey,
                    litems: Provider.of<List<Map>>(context) ?? [],
                    fetch: () {
                      return [];
                    },
                    goPeople: (data) => widget.onPush(data),
                  );
                }) */
            ));
  }
}

class SwipeList extends StatefulWidget {
  SwipeList({Key key, this.litems, this.fetch, this.goPeople})
      : super(key: key);

  final List litems;
  final Function fetch;
  final ValueChanged<Map> goPeople;
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  ScrollController _scrollController = new ScrollController();

  void goUp() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void seeRecipe(String id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      print(widget.litems.toString());
      return RefreshIndicator(
        onRefresh: () async {
          return await Future.delayed(Duration(seconds: 1), widget.fetch());
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          padding: const EdgeInsets.all(10),
          itemCount: widget.litems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Row(
                          children: [
                            Stack(children: [
                              InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    Map<String, dynamic> data =
                                        new Map<String, dynamic>();

                                    data["route"] = TabRouterFeed.people;
                                    data["id"] =
                                        widget.litems[index]["user"].id;

                                    widget.goPeople(data);
                                  },
                                  child: CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage(widget
                                          .litems[index]["user"].imgUrl))),
                              widget.litems[index]["user"].proUser
                                  ? Positioned(
                                      right: -3,
                                      bottom: -3,
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          onTap: () {
                                            Map<String, dynamic> data =
                                                new Map<String, dynamic>();

                                            data["route"] =
                                                TabRouterFeed.people;
                                            data["id"] =
                                                widget.litems[index]["user"].id;
                                            widget.goPeople(data);
                                          },
                                          child: Icon(
                                            Icons.brightness_5,
                                            color: Colors.blue,
                                            size: 20,
                                          )))
                                  : Text("")
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.litems[index]["user"].username,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      widget.litems[index]["name"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          //widget.litems[index]["id"]
                          seeRecipe("pqbdR1eCNIm9hN3fzvrU");
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                height: 310,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      widget.litems[index]["image"],
                                      width: MediaQuery.of(context).size.width,
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
                                                    progress.expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                    )))),
                      ),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.litems[index]["likes"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(
                              " pessoas gostaram desta receita",
                              style: TextStyle(fontSize: 14),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  if (widget.litems[index]["me"]["liked"]) {
                                    print("TIRAR LIKE NA RECEITA " +
                                        widget.litems[index]["id"].toString());
                                    setState(() {
                                      widget.litems[index]["likes"]--;
                                      widget.litems[index]["me"]["liked"] =
                                          false;
                                    });
                                  } else {
                                    print("DAR LIKE NA RECEITA " +
                                        widget.litems[index]["id"].toString());
                                    setState(() {
                                      widget.litems[index]["likes"]++;
                                      widget.litems[index]["me"]["liked"] =
                                          true;
                                    });
                                  }
                                },
                                child: widget.litems[index]["me"]["liked"]
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.amber[800],
                                        size: 34,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        size: 34,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  if (widget.litems[index]["me"]["saved"]) {
                                    print("TIRAR DOS GUARDADOS " +
                                        widget.litems[index]["id"].toString());
                                  } else {
                                    main_key.currentState
                                        .push(MaterialPageRoute(
                                            builder: (context) => SaveRecipe(
                                                  recipeId: widget.litems[index]
                                                      ["id"],
                                                  onSave: (saved) {
                                                    if (saved) {
                                                      print(
                                                          "GUARDAR DOS GUARDADOS " +
                                                              widget
                                                                  .litems[index]
                                                                      ["id"]
                                                                  .toString());
                                                    }
                                                  },
                                                )));
                                  }
                                },
                                child: widget.litems[index]["me"]["saved"]
                                    ? Icon(
                                        Icons.bookmark,
                                        color: Colors.amber[800],
                                        size: 34,
                                      )
                                    : Icon(
                                        Icons.bookmark_border,
                                        size: 34,
                                      ),
                              ),
                            )
                          ]),
                    ]),
              ),
            );
          },
        ),
      );
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento nenhuma pessoa a seguir",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
