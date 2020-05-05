import 'package:flutter/material.dart';

class Colletions extends StatefulWidget {
  Colletions({
    Key key,
    this.onPop,
    this.colletionName,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final String colletionName;
  _ColletionsState createState() => _ColletionsState();
}

class _ColletionsState extends State<Colletions> {
  static List onSomeEvent2() {
    List<String> litems = ["1", "2", "3", "4", "5"];
    return litems;
  }

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
                        padding: const EdgeInsets.only(top: 20),
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
                      padding: const EdgeInsets.only(top: 15),
                      child: GridList(
                        litems: onSomeEvent2(),
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
                  child: Center(child: Text(widget.litems[index])),
                )),
          );
        });
  }
}
