import 'package:flutter/material.dart';
import 'package:instacook/receitas/see_recipe.dart';
import '../main.dart';
import '../router.dart';

class MainGuardado extends StatefulWidget {
  MainGuardado({
    Key key,
    this.onPush,
  }) : super(key: key);

  final ValueChanged<Map<String, dynamic>> onPush;

  _MainGuardadoState createState() => _MainGuardadoState();
}

class _MainGuardadoState extends State<MainGuardado> {
  static List onSomeEvent() {
    List<Map<String, dynamic>> litems = [
      {
        "id": 1,
        "name": "Pregos",
        "image":
            "https://nit.pt/wp-content/uploads/2018/07/95915588dd8f97db9b5bedd24ea068a5-754x394.jpg"
      },
      {
        "id": 2,
        "name": "Peixes",
        "image":
            "https://s2.glbimg.com/sGfe5ndqXQ_LPvFNH24x0akv0NE=/300x375/e.glbimg.com/og/ed/f/original/2014/02/03/cc22api_184.jpg"
      },
      {
        "id": 3,
        "name": "Pizzas",
        "image": "https://www.delonghi.com/Global/recipes/multifry/3.jpg"
      },
      {
        "id": 4,
        "name": "Carnes",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTpgNdlNQQ2rGCZhwTe16Dc3axujG2UtE_4Q8R77Y0LSrG58Zjf&usqp=CAU"
      },
    ];

    litems.insert(0, {"name": "Novo livro"});
    return litems;
  }

  static List onSomeEvent2() {
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
                          padding: const EdgeInsets.only(
                              top: 10, right: 60, left: 15),
                          child: Text(
                            "Receitas Guardadas",
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
                      padding: const EdgeInsets.only(top: 25),
                      child: SwipeList(
                        litems: onSomeEvent(),
                        onPush: widget.onPush,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: GridList(
                        litems: onSomeEvent2(),
                      ),
                    )
                  ],
                ))));
  }
}

//ESCOLHER LIVRO DE RECEITAS
class SwipeList extends StatefulWidget {
  SwipeList({
    Key key,
    this.litems,
    this.onPush,
  }) : super(key: key);

  final List litems;

  final ValueChanged<Map<String, dynamic>> onPush;
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.litems.length,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                              Border.all(color: Colors.amber[900], width: 2)),
                      margin: EdgeInsets.only(right: 10.0, left: 10),
                      child: InkWell(
                          enableFeedback: true,
                          splashColor: Colors.amber[900],
                          onTap: () {
                            Map<String, dynamic> data = ({
                              "route": TabRouterSaved.create,
                            });

                            print(data);
                            widget.onPush(data);
                          },
                          borderRadius: BorderRadius.circular(200),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.amber[900],
                            ),
                          ))),
                  Container(
                    width: 100,
                    child: Text(
                      widget.litems[index]["name"],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  )
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                            image: NetworkImage(widget.litems[index]["image"]),
                            fit: BoxFit.fitHeight),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.amber[900], width: 2)),
                    margin: EdgeInsets.only(right: 10.0, left: 10),
                    child: InkWell(
                      enableFeedback: true,
                      splashColor: Colors.amber[900],
                      onTap: () {
                        Map<String, dynamic> data = ({
                          "route": TabRouterSaved.saved,
                          "title": widget.litems[index]["name"]
                        });

                        print(data);
                        widget.onPush(data);
                      },
                      borderRadius: BorderRadius.circular(200),
                    )),
                Container(
                  width: 100,
                  child: Text(
                    widget.litems[index]["name"],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                  ),
                )
              ],
            );
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
                          seeRecipe(widget.litems[index]["id"]);
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
