import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/models/User.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/userService.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../router.dart';

/* GlobalKey<GrodListFoodItemWidget> globalKey = GlobalKey();
GlobalKey<GrodListPeopleItemWidget> globalKey2 = GlobalKey(); */

class Search extends StatefulWidget {
  Search({
    Key key,
    this.onPop,
    this.onPush,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final ValueChanged<Map<String, dynamic>> onPush;

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _userService = UserService();
  final _auth = AuthService();
  final _search = TextEditingController();

  //Search value

  static List onSomeEvent() {
    List<Map> litems = [
      {
        "category": "Carne",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
      },
      {
        "category": "Peixe",
        "image":
            "https://cdn.tasteatlas.com/images/dishes/7972bd53485e4091822b9ada99786867.jpg?w=600&h=450",
      },
      {
        "category": "Pizza",
        "image":
            "https://www.tasteofhome.com/wp-content/uploads/2018/01/Homemade-Pizza_EXPS_HCA20_376_E07_09_2b.jpg",
      },
      {
        "category": "Massas",
        "image":
            "https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/spaghetti-puttanesca_1.jpg",
      },
      {
        "category": "Bebidas",
        "image":
            "https://i0.wp.com/www.foodrepublic.com/wp-content/uploads/2015/12/Zonso-de-yuca-Photo-Restaurant-Gustu-e1449509832700.jpg?fit=2050%2C1789&ssl=1",
      },
      {
        "category": "Sobremesa",
        "image":
            "https://c.pxhere.com/photos/74/ba/cheesecake_pastry_cake_grout_eat_sweet_desert_slice_of_cake-791966.jpg!d",
      },
      {
        "category": "Vegetariano",
        "image":
            "https://images.immediate.co.uk/production/volatile/sites/2/2017/04/carot-falafel_charlie-richards.cropped.jpg?quality=45&resize=768,574",
      },
      {
        "category": "Entrada",
        "image":
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-cranberry-brie-bites-vertical-2-1540486092.jpg",
      },
      {
        "category": "Sopas",
        "image":
            "https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&url=https%3A%2F%2Fcdn-image.myrecipes.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Froasted-carrot-and-coconut-soup-1811-p38.jpg%3Fitok%3DSqJ9ZPK2",
      },
      {
        "category": "Saladas",
        "image":
            "https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2017/06/beetroot_halloumi_salad.jpg",
      },
    ];
    return litems;
  }

  void setNewState(bool food, bool isFoods) {
    var colors1, colors2;
    if (food) {
      //globalKey.currentState.goUp();
      colors1 = Colors.amber[800];
      colors2 = Colors.grey[900];
    } else {
      //globalKey2.currentState.goUp();
      colors2 = Colors.amber[800];
      colors1 = Colors.grey[900];
    }
    setState(() {
      color1 = colors1;
      color2 = colors2;
      isFood = isFoods;
      _search.text = "";
    });
  }

  Color color2 = Colors.grey[900];
  Color color1 = Colors.amber[800];
  bool isFood = true;
  Future<String> getUserId() async {
    var myId = await _userService.getMyID(await _auth.getCurrentUser());

    return myId;
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
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Column(children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 8.0, right: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: TextField(
                                          controller: _search,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              height: 0.7,
                                              color: Colors.black),
                                          onChanged: (text) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.black,
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50.0)),
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5),
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
                                    padding: const EdgeInsets.all(25.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (!isFood) {
                                                  setNewState(true, true);
                                                }
                                              },
                                              child: Icon(
                                                Icons.local_dining,
                                                size: 35,
                                                color: color1,
                                              )),
                                          InkWell(
                                              onTap: () {
                                                if (isFood) {
                                                  setNewState(false, false);
                                                }
                                              },
                                              child: Icon(Icons.account_circle,
                                                  size: 35, color: color2)),
                                        ]),
                                  )
                                ])),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: !isFood
                                  ? _userSearch(snapshots)
                                  : GrodListFood(
                                      //key: globalKey,
                                      litems: onSomeEvent(),
                                      onPush: widget.onPush,
                                      search: _search.text,
                                      myId: snapshots.data),
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

  Widget _userSearch(dynamic snapshots) {
    return StreamProvider<List<User>>.value(
        value: _search.text == ""
            ? _userService.getAllUsersStream()
            : _userService.getAllUsersStreamSearch("username", _search.text),
        builder: (context, snapshot) {
          return GridListPeople(
            //key: globalKey2,
            litems: Provider.of<List<User>>(context) ?? [],
            onPush: widget.onPush,
            myId: snapshots.data,
          );
        });
  }
}

//GRID VIEW

class GrodListFood extends StatefulWidget {
  GrodListFood({Key key, this.litems, this.onPush, this.search, this.myId})
      : super(key: key);

  final List litems;
  final ValueChanged<Map<String, dynamic>> onPush;
  final String myId;
  String search;
  @override
  State<StatefulWidget> createState() {
    return GrodListFoodItemWidget();
  }
}

class GrodListFoodItemWidget extends State<GrodListFood> {
  ScrollController _scrollController = new ScrollController();
  final _recipesService = RecipeService();

  void goUp() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.search != ""
        ? StreamProvider<List<Recipe>>.value(
            value: _recipesService.getMyRecipesSearch("name", widget.search),
            builder: (context, snapshot) {
              return GridList(
                myId: widget.myId,
                litems: Provider.of<List<Recipe>>(context) ?? [],
              );
            })
        : GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            primary: false,
            itemCount: widget.litems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.9),
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
                            height: 45,
                          ),
                    Container(
                      height: 175,
                      width: 300,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            Map<String, dynamic> data =
                                new Map<String, dynamic>();

                            data["route"] = TabRouterFeed.details;
                            data["id"] = widget.litems[index]["category"];
                            widget.onPush(data);
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
                                      widget.litems[index]["image"],
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
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 2),
                                  child: Text(
                                    widget.litems[index]["category"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[800]),
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

//GRID VIEW

class GridListPeople extends StatefulWidget {
  GridListPeople({
    Key key,
    this.litems,
    this.onPush,
    this.myId,
  }) : super(key: key);

  List litems;
  final ValueChanged<Map<String, dynamic>> onPush;
  final String myId;
  @override
  State<StatefulWidget> createState() {
    return GrodListPeopleItemWidget();
  }
}

class GrodListPeopleItemWidget extends State<GridListPeople> {
  ScrollController _scrollController = new ScrollController();
  void goUp() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.litems.removeWhere((element) => element.id == widget.myId);
    return widget.litems.length == 0
        ? Text("Utilizador não encontrado")
        : GridView.builder(
            controller: _scrollController,
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
                            height: 45,
                          ),
                    Container(
                      height: 175,
                      width: 300,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            Map<String, dynamic> data =
                                new Map<String, dynamic>();

                            data["route"] = TabRouterFeed.people;
                            data["id"] = widget.litems[index].id;
                            widget.onPush(data);
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 140,
                                  width: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
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
                                                    progress.expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 2),
                                  child: Text(
                                    widget.litems[index].username,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800]),
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

//Grid Pesquisa
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
    return widget.litems.length == 0
        ? Text("Receita não encontrada")
        : GridView.builder(
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
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 2),
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
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 2),
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
  }
}
