import 'package:flutter/material.dart';

class MainReceita extends StatefulWidget {
  _MainReceitalState createState() => _MainReceitalState();
}

class _MainReceitalState extends State<MainReceita> {
  static List onSomeEvent() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                onSomeEvent();
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
              onPressed: () {},
            ),
            // action button
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.amber[800],
                size: 30,
              ),
              onPressed: () {},
            ),
            // overflow menu
          ],
        ),
        body: Center(
            child: SwipeList(
          litems: onSomeEvent(),
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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
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
            ));
      },
    ));
  }
}
