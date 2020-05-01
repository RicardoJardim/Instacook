import 'package:flutter/material.dart';
import '../router.dart';

GlobalKey<ListItemWidget> globalKey = GlobalKey();

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
          title: GestureDetector(
              onTap: () {
                globalKey.currentState.goUp();
                setState(() {
                  litems = event();
                });
              },
              child: Text(
                "SEARCH",
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
                onPressed: () => widget.onPop(context)),

            // action button
            IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.amber[800],
                  size: 30,
                ),
                onPressed: () {
                  Map<String, dynamic> data = new Map<String, dynamic>();
                  data["route"] = TabRouterFeed.details;

                  widget.onPush(data);
                }),

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

  @override
  Widget build(BuildContext context) {
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
                child: Center(
                  child: Text(widget.litems[index]),
                ),
              ));
        },
      ),
    );
  }
}
