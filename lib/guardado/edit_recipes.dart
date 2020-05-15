import 'package:flutter/material.dart';
import '../main.dart';

class EditRecipes extends StatefulWidget {
  EditRecipes({Key key, this.id}) : super(key: key);
  final int id;

  _EditRecipesState createState() => _EditRecipesState();
}

class _EditRecipesState extends State<EditRecipes> {
  Map getLista2(int id) {
    var collection = new Map<String, dynamic>();

    collection = {
      "id": id,
      "name": "Pregos",
      "recipes": [
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
      ]
    };
    return collection;
  }

  void initState() {
    collection = getLista2(widget.id);
    super.initState();
  }

  void save() {
    if (removeRecipes.length != 0) {
      removeRecipes.forEach((el) {
        print("remove recipe with id " + el.toString());
      });
    }
    main_key.currentState.pop(context);
  }

  List removeRecipes = [];
  Map<String, dynamic> collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Remover receitas"),
          actions: <Widget>[
            IconButton(
              enableFeedback: true,
              tooltip: "confirmar",
              icon: Icon(
                Icons.check,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                save();
              },
            ),
            // overflow menu
          ],
        ),
        body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GridList(
                  litems: collection["recipes"],
                  onClickRecipe: (id) {
                    var aux = removeRecipes;
                    if (removeRecipes.contains(id)) {
                      aux.remove(id);
                      print("aux: " + aux.toString());
                    } else {
                      aux.add(id);
                      print("aux: " + aux.toString());
                    }
                    setState(() {
                      removeRecipes = aux;
                    });
                    aux = null;
                  }),
            )));
  }
}
//GRID VIEW

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({Key key, this.litems, this.onClickRecipe}) : super(key: key);

  final List litems;
  final ValueChanged<int> onClickRecipe;

  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: widget.litems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.92),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                height: 190,
                width: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 140,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              ClipRRect(
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
                              Positioned(
                                  right: -2,
                                  bottom: -2,
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0) //         <--- border radius here
                                          ),
                                    ),
                                    child: CheckBoxWidget(
                                      callback: () => widget.onClickRecipe(
                                          widget.litems[index]["id"]),
                                    ),
                                  ))
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 2),
                        child: Text(
                          widget.litems[index]["name"],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
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
                    ]),
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

class CheckBoxWidget extends StatefulWidget {
  CheckBoxWidget({Key key, this.callback}) : super(key: key);

  final Function callback;
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBoxWidget> {
  void onChanged(bool newValue) {
    setState(() {
      value = newValue;
    });
    widget.callback();
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.6,
        child: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.amber[800],
          value: value,
          onChanged: (bool newValue) {
            onChanged(newValue);
          },
        ));
  }
}
