import 'package:flutter/material.dart';

class People extends StatefulWidget {
  People({
    Key key,
    this.onPop,
    this.colletionName,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final String colletionName;
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  static int seguidores = 44;
  static int aseguir = 28;
  static bool pro = true;
  static String name = "Diana C. Faria";
  static String photo = 'https://picsum.photos/250?image=9';
  static bool subcribed = false;

  static List onSomeEvent() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

  final List litems = onSomeEvent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Center(
                          child: Column(
                        children: <Widget>[
                          Container(
                              height: 110,
                              width: 120,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.network(
                                        photo,
                                      )),
                                ),
                                pro
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(
                                          Icons.brightness_5,
                                          color: Colors.blue,
                                          size: 36,
                                        ))
                                    : Text("")
                              ])),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "$name",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("$seguidores seguidores"),
                                Text(" - "),
                                Text("$aseguir a seguir")
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: _submitButton(),
                          ),
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: GridList(
                        litems: litems,
                      ),
                    )
                  ],
                ))));
  }

  Widget _submitButton() {
    if (subcribed) {
      return RaisedButton(
        elevation: 5,
        splashColor: Colors.amber,
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 60, right: 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: Colors.amber[800],
        onPressed: () {
          setState(() {
            subcribed = false;
          });
        },
        textColor: Colors.white,
        child: Text(
          'Seguir',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      );
    } else {
      return RaisedButton(
        elevation: 5,
        splashColor: Colors.amber[800],
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 60, right: 60),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.amber[800]),
          borderRadius: BorderRadius.circular(100),
        ),
        color: Colors.white,
        onPressed: () {
          setState(() {
            subcribed = true;
          });
        },
        textColor: Colors.amber[800],
        child: Text(
          'Não Seguir',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      );
    }
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
    if (widget.litems.length != 0) {
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
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      /* Map<String, dynamic> data = new Map<String, dynamic>();

                        data["route"] = TabRouterFeed.people;
                        data["title"] = widget.litems[index];
                        widget.onPush(data); */
                    },
                    child: Container(
                        height: 200.0,
                        child: Center(child: Text(widget.litems[index]))),
                  )),
            );
          });
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento receitas criadas",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
