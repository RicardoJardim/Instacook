import 'package:flutter/material.dart';

class MainGuardado extends StatefulWidget {
  _MainGuardadoState createState() => _MainGuardadoState();
}

class _MainGuardadoState extends State<MainGuardado> {
  static List onSomeEvent() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  static List onSomeEvent2() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 60, left: 15),
                  child: Text(
                    "Receitas Guardadas",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                ),
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
                  padding: const EdgeInsets.only(top: 25),
                  child: SwipeList(
                    litems: onSomeEvent(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GridList(
                    litems: onSomeEvent2(),
                  ),
                )
              ],
            )));
  }
}

//ESCOLHER LIVRO DE RECEITAS
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
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.litems.length,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            return Container(
                width: 100,
                margin: EdgeInsets.only(right: 10.0, left: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(widget.litems[index]),
                ));
          },
        ));
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
  var first = false;

  double itemHeight(int index) {
    if (!first) {
      if (index % 2 == 0) {
        return 8.0;
      } else {
        first = true;
        return 50.0;
      }
    } else {
      return 8.0;
    }
  }
  //double itemHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.litems.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                child: Container(
                  height: 200.0,
                  child: Center(child: Text(widget.litems[index])),
                )),
          );
        });
  }
}
