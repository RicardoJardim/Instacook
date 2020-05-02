import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details({
    Key key,
    this.onPop,
    this.colletionName,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final String colletionName;
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  static List onSomeEvent2() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  List litems = onSomeEvent2();

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
                    child: Text(widget.colletionName,
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
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 60, left: 15),
                      child: Text(
                        widget.colletionName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 95,
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
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            splashColor: Colors.white,
                            onTap: () {
                              scaffoldKey.currentState.openEndDrawer();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8, left: 15, right: 15),
                              child: Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GridList(
                    litems: litems,
                  ),
                )
              ],
            )));
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                child: Container(
                  height: 200.0,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        /* Map<String, dynamic> data = new Map<String, dynamic>();

                        data["route"] = TabRouterFeed.people;
                        data["title"] = widget.litems[index];
                        widget.onPush(data); */
                      },
                      child: Center(child: Text(widget.litems[index]))),
                )),
          );
        });
  }
}
