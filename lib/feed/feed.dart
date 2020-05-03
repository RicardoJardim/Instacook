import 'package:flutter/material.dart';
import 'package:instacook/receitas/see_recipe.dart';
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
  static List onSomeEvent() {
    litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  static List event() {
    List<String> items = [];
    for (var item in litems) {
      items.add(item + "1");
    }
    return items;
  }

  static List<String> litems = onSomeEvent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
              onTap: () {
                globalKey.currentState.goUp();
                setState(() {
                  litems = event();
                });
              },
              child: Text(
                "Instacook",
                style: TextStyle(
                    fontFamily: "CreamCake",
                    fontSize: 40,
                    fontWeight: FontWeight.w200),
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
                print("add Recipe");
              },
            ),
            // overflow menu
          ],
        ),
        body: Center(
            child: SwipeList(
          key: globalKey,
          litems: litems,
        )));
  }
}

class SwipeList extends StatefulWidget {
  SwipeList({
    Key key,
    this.litems,
  }) : super(key: key);

  final List litems;
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
      return Container(
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          itemCount: widget.litems.length,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.only(bottom: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.blue,
                elevation: 10,
                child: Container(
                  height: 300.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      seeRecipe(widget.litems[index]);
                    },
                    child: Center(child: Text(widget.litems[index])),
                  ),
                ));
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
