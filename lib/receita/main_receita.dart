import 'package:flutter/material.dart';

class MainReceita extends StatefulWidget {
  _MainReceitalState createState() => _MainReceitalState();
}

class _MainReceitalState extends State<MainReceita> {
  static List onSomeEvent() {
    List list = List.generate(5, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                onSomeEvent();
              },
              child: Text("Instacook")),
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
        body: Center(child: SwipeList(items: onSomeEvent())));
  }
}

class SwipeList extends StatefulWidget {
  SwipeList({
    Key key,
    this.items,
  }) : super(key: key);

  final List items;
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
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.only(bottom: 30.0),
            color: Colors.blue,
            elevation: 10,
            child: Container(
              height: 250.0,
            ));
      },
    ));
  }
}
