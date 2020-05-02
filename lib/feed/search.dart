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
    List<String> litems = ["Carnes", "Peixes", "Pizzas", "Bolos", "Veg"];
    return litems;
  }

  static List event() {
    List<String> items = ["ricardo", "lucas", "Jardim"];
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

  List<String> litems = onSomeEvent();
  Color color2 = Colors.grey[900];
  Color color1 = Colors.amber[800];
  bool isFood = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                widget.onPop(context);
                              },
                              child: Container(
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.black,
                                  size: 50,
                                ),
                              )),
                        ),
                      ),
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
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  padding: const EdgeInsets.only(top: 15),
                  child: GridList(
                    key: globalKey,
                    litems: litems,
                    isFood: isFood,
                    onPush: widget.onPush,
                  ),
                )
              ],
            )));
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
                        Map<String, dynamic> data = new Map<String, dynamic>();

                        data["route"] = TabRouterFeed.details;
                        data["title"] = widget.litems[index];
                        widget.onPush(data);
                      },
                      child: Container(
                        height: 200.0,
                        child: Center(child: Text(widget.litems[index])),
                      ))),
            );
          });
    } else {
      return GridView.builder(
          controller: _scrollController,
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
                        Map<String, dynamic> data = new Map<String, dynamic>();

                        data["route"] = TabRouterFeed.people;
                        data["title"] = widget.litems[index];
                        widget.onPush(data);
                      },
                      child: Container(
                        height: 200.0,
                        child: Center(child: Text(widget.litems[index])),
                      ))),
            );
          });
    }
  }
}
