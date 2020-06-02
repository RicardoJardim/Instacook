import 'package:flutter/material.dart';
import 'package:instacook/receitas/see_recipe.dart';

import '../main.dart';

class Details extends StatefulWidget {
  Details({
    Key key,
    this.onPop,
    this.id,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final int id;
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  static Map onSomeEvent2() {
    var searchDetail = new Map<String, dynamic>();

    searchDetail = {
      "id": 1,
      "name": "Carne",
      "recipes": [
        {
          "id": 1,
          "name": "Bife de vaca",
          "image":
              "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
          "time": "5-10 minutos",
          "difficulty": "Difícil"
        },
        {
          "id": 2,
          "name": "Hamburguer de porco",
          "image":
              "https://s1.1zoom.me/b5446/532/Fast_food_Hamburger_French_fries_Buns_Wood_planks_515109_1920x1080.jpg",
          "time": "5-10 minutos",
          "difficulty": "Fácil"
        },
        {
          "id": 3,
          "name": "Bife de vaca",
          "image":
              "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
          "time": "5-10 minutos",
          "difficulty": "Médio"
        },
        {
          "id": 4,
          "name": "Bife de vaca",
          "image":
              "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
          "time": "5-10 minutos",
          "difficulty": "Difícil"
        },
      ],
      "follow": 28,
      "followers": 44
    };
    return searchDetail;
  }

  void initState() {
    searchDetail = onSomeEvent2();
    super.initState();
  }

  static Map<String, dynamic> searchDetail;

  bool switch1 = false;
  bool switch2 = false;

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
                    child: Text(searchDetail["name"],
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
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 60, left: 15),
                          child: Text(
                            searchDetail["name"],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                              hintText: 'Enter a search term',
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GridList(
                        litems: searchDetail["recipes"],
                      ),
                    )
                  ],
                ))));
  }
}
//GRID VIEW

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
  //double itemHeight = 8.0;

  void seeRecipe(String id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
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
                        seeRecipe(widget.litems[index]["id"]);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 140,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.litems[index]["image"],
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
                                widget.litems[index]["name"],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 2),
                              child: Text(
                                widget.litems[index]["time"] +
                                    " - " +
                                    widget.litems[index]["difficulty"],
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
