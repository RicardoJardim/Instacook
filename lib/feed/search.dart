import 'package:flutter/material.dart';
import '../router.dart';

GlobalKey<GridItemWidget> globalKey = GlobalKey();

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
  static List onSomeEvent() {
    List<Map> litems = [
      {
        "id": 1,
        "category": "Carne",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
      },
      {
        "id": 2,
        "category": "Peixe",
        "image":
            "https://s1.1zoom.me/b5446/532/Fast_food_Hamburger_French_fries_Buns_Wood_planks_515109_1920x1080.jpg",
      },
      {
        "id": 3,
        "category": "Pizza",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
      },
      {
        "id": 4,
        "category": "Massas",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
      },
    ];
    return litems;
  }

  static List event() {
    List<Map> items = [
      {
        "id": 1,
        "username": "Ricardo",
        "pro": true,
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
      },
      {
        "id": 2,
        "username": "Lucas",
        "pro": false,
        "image":
            "https://s1.1zoom.me/b5446/532/Fast_food_Hamburger_French_fries_Buns_Wood_planks_515109_1920x1080.jpg",
      },
      {
        "id": 3,
        "username": "Jardim",
        "pro": true,
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
      },
    ];
    return items;
  }

  void setNewState(bool food, bool isFoods) {
    var newItems, colors1, colors2;
    if (food) {
      newItems = onSomeEvent();
      colors1 = Colors.amber[800];
      colors2 = Colors.grey[900];
    } else {
      newItems = event();
      colors2 = Colors.amber[800];
      colors1 = Colors.grey[900];
    }
    setState(() {
      litems = newItems;
      color1 = colors1;
      color2 = colors2;
      isFood = isFoods;
    });
  }

  List<Map> litems = onSomeEvent();
  Color color2 = Colors.grey[900];
  Color color1 = Colors.amber[800];
  bool isFood = true;

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
        body: SafeArea(
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
                      child: GridList(
                        key: globalKey,
                        litems: litems,
                        isFood: isFood,
                        onPush: widget.onPush,
                      ),
                    )
                  ],
                ))));
  }
}

//GRID VIEW

class GridList extends StatefulWidget {
  GridList({
    Key key,
    this.litems,
    this.isFood,
    this.onPush,
  }) : super(key: key);

  final bool isFood;
  final List litems;
  final ValueChanged<Map<String, dynamic>> onPush;
  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  ScrollController _scrollController = new ScrollController();

  void goUp() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  //double itemHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    if (widget.isFood) {
      return GridView.builder(
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
                          data["id"] = widget.litems[index]["id"];
                          widget.onPush(data);
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
    } else {
      return GridView.builder(
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
                          data["id"] = widget.litems[index]["id"];
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
                                  widget.litems[index]["username"],
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
}
