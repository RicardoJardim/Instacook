import 'package:flutter/material.dart';
import 'package:instacook/receitas/see_recipe.dart';

import '../main.dart';

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
  static String photo = 'https://picsum.photos/250?image=9';
  static bool subcribed = false;

  static List onSomeEvent() {
    List<Map> litems = [
      {
        "id": 1,
        "name": "Bife de vaca",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
        "time": "5-10 minutos",
        "difficulty": "Difícil"
      },
      {
        "id": 2,
        "name": "Hamburguer de porco",
        "image":
            "https://s1.1zoom.me/b5446/532/Fast_food_Hamburger_French_fries_Buns_Wood_planks_515109_1920x1080.jpg",
        "time": "5-10 minutos",
        "difficulty": "Fácil"
      },
      {
        "id": 3,
        "name": "Bife de vaca",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
        "time": "5-10 minutos",
        "difficulty": "Intermédio"
      },
      {
        "id": 4,
        "name": "Bife de vaca",
        "image":
            "https://img.itdg.com.br/tdg/images/blog/uploads/2018/04/bife-de-carne-vermelha.jpg?w=1200",
        "time": "5-10 minutos",
        "difficulty": "Difícil"
      },
    ];
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
                              height: 120,
                              width: 130,
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
                              widget.colletionName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                                "$seguidores seguidores - $aseguir a seguir"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: _submitButton(),
                          ),
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
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
        elevation: 2,
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
        elevation: 2,
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
  void seeRecipe(int id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: widget.litems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.88),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: <Widget>[
                  index % 2 != 1
                      ? SizedBox(
                          height: 0,
                        )
                      : SizedBox(
                          height: 35,
                        ),
                  Container(
                    height: 190,
                    width: 300,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          //  seeRecipe(widget.litems[index]["id"]);
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
                                  widget.litems[index]["name"],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  widget.litems[index]["time"] +
                                      " - " +
                                      widget.litems[index]["difficulty"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700]),
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
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento receitas criadas",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
