import 'package:flutter/material.dart';
import 'package:instacook/feed/people.dart';
import 'package:instacook/receitas/create/create_recipe.dart';
import 'package:instacook/receitas/prepare_recipe.dart';
import 'package:instacook/receitas/save_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/shopService.dart';
import 'Widget/ButtonsContainer.dart';
import '../main.dart';

class SeeRecipe extends StatefulWidget {
  SeeRecipe({
    Key key,
    this.id,
    this.goProfile: true,
    this.mine: false,
  }) : super(key: key);

  final int id;
  final bool goProfile;
  final bool mine;
  _SeeRecipelState createState() => _SeeRecipelState();
}

class _SeeRecipelState extends State<SeeRecipe> {
  final _auth = AuthService();
  final _shopService = ShopService();

  Map getLista2(int id) {
    var receita = new Map<String, dynamic>();

    receita = {
      "id": id,
      "name": "Hamburguer de Frango",
      "props": 2,
      "likes": 1020,
      "time": "5-10 minutos",
      "type": "carnes",
      "difficulty": "Difícil",
      "privacy": true,
      "description":
          "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500, quando uma misturou os caracteres de um texto para criar um espécime de livro. Este texto não só sobreviveu 5 séculos, mas também o salto para a tipografia electrónica, mantendo-se essencialmente inalterada. Foi popularizada nos anos 60 com a disponibilização das folhas de Letraset, que continham passagens com Lorem Ipsum, e mais recentemente com os programas de publicação como o Aldus PageMaker que incluem versões do Lorem Ipsum",
      "image":
          "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg",
      "prods": [
        {"quant": 200, "type": "mg", "prod": "leite"},
        {"quant": 100, "type": "mg", "prod": "merda"},
        {"quant": 50, "type": "mg", "prod": "merda"},
        {"quant": 0.5, "type": "mg", "prod": "merda"},
      ],
      "user": {
        "id": 1,
        "username": "Ricardo Lucas",
        "pro": true,
        "image":
            "https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg",
      }
    };
    return receita;
  }

  bool getLiked(int id) {
    return true;
  }

  bool getSaved(int id) {
    return false;
  }

  @override
  void initState() {
    receita = getLista2(widget.id);
    liked = getLiked(widget.id);
    saved = getSaved(widget.id);
    backgroundColor = Colors.amber[600];
    super.initState();
  }

  void addIngredients() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Adicionar à lista de compras"),
          content: new Text("Deseja adicionar à lista de compras?"),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () async {
                String _id = await _auth.getCurrentUser();
                Map data = {
                  "name": receita["name"],
                  "props": ingredients_key.currentState.widget.props,
                  "prods": ingredients_key.currentState.widget.litems,
                };
                print(data);
                await _shopService.insertShop(_id, data);
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }

  Map<String, dynamic> receita = new Map<String, dynamic>();
  bool liked;
  bool saved;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 50,
            ),
            onPressed: () => main_key.currentState.pop(context),
          ),
          actions: <Widget>[
            widget.mine
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      main_key.currentState.push(MaterialPageRoute(
                          builder: (context) => CreateRecipe(
                                editRecipe: receita,
                              )));
                    })
                : Text(""),
          ],
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, right: 90, left: 15),
                        child: Text(
                          receita["name"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w700),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(8, 8), //(x,y)
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              receita["image"],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              filterQuality: FilterQuality.high,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ))),
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          receita["likes"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text(
                          " pessoas gostaram desta receita",
                          style: TextStyle(fontSize: 14),
                        ),
                        !widget.mine
                            ? Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    if (liked) {
                                      print("TIRAR LIKE NA RECEITA");
                                      setState(() {
                                        receita["likes"]--;
                                        liked = false;
                                      });
                                    } else {
                                      print("DAR LIKE NA RECEITA");
                                      setState(() {
                                        receita["likes"]++;
                                        liked = true;
                                      });
                                    }
                                  },
                                  child: liked
                                      ? Icon(
                                          Icons.favorite,
                                          size: 34,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          size: 34,
                                        ),
                                ),
                              )
                            : Text(""),
                        !widget.mine
                            ? Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    if (saved) {
                                      print("TIRAR DOS GUARDADOS");
                                      setState(() {
                                        saved = false;
                                      });
                                    } else {
                                      main_key.currentState
                                          .push(MaterialPageRoute(
                                              builder: (context) => SaveRecipe(
                                                    recipeId: widget.id,
                                                    onSave: (saveds) {
                                                      setState(() {
                                                        saved = saveds;
                                                      });
                                                      if (saved) {
                                                        print(
                                                            "GUARDAR DOS GUARDADOS " +
                                                                widget.id
                                                                    .toString());
                                                      }
                                                    },
                                                  )));
                                    }
                                  },
                                  child: saved
                                      ? Icon(
                                          Icons.bookmark,
                                          size: 34,
                                        )
                                      : Icon(
                                          Icons.bookmark_border,
                                          size: 34,
                                        ),
                                ),
                              )
                            : Text("")
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Stack(children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                if (widget.goProfile) {
                                  main_key.currentState.push(MaterialPageRoute(
                                      builder: (context) => People(
                                            id: receita["user"]["id"],
                                            onPop: (context) => main_key
                                                .currentState
                                                .pop(context),
                                          )));
                                }
                              },
                              child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      NetworkImage(receita["user"]["image"]))),
                          receita["user"]["pro"]
                              ? Positioned(
                                  right: -3,
                                  bottom: -3,
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {
                                        if (widget.goProfile) {
                                          main_key.currentState
                                              .push(MaterialPageRoute(
                                                  builder: (context) => People(
                                                        id: receita["user"]
                                                            ["id"],
                                                        onPop: (context) =>
                                                            main_key
                                                                .currentState
                                                                .pop(context),
                                                      )));
                                        }
                                      },
                                      child: Icon(
                                        Icons.brightness_5,
                                        color: Colors.blue,
                                        size: 20,
                                      )))
                              : Text("")
                        ]),
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 15),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                if (widget.goProfile) {
                                  main_key.currentState.push(MaterialPageRoute(
                                      builder: (context) => People(
                                            id: receita["user"]["id"],
                                            onPop: (context) => main_key
                                                .currentState
                                                .pop(context),
                                          )));
                                }
                              },
                              child: Text(
                                receita["user"]["username"],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      receita["description"],
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              "  " + receita["time"],
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.local_offer,
                              color: Colors.black,
                              size: 30,
                            ),
                            Text(
                              "  " + receita["type"],
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Row(children: <Widget>[
                          Icon(
                            Icons.assessment,
                            color: Colors.black,
                            size: 30,
                          ),
                          Text(
                            receita["difficulty"],
                            style: TextStyle(fontSize: 16),
                          )
                        ])
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: FlatButton(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      color: backgroundColor,
                      onPressed: () {
                        addIngredients();
                      },
                      textColor: Colors.black,
                      child: Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Adicionar ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.event_available,
                              color: Colors.black,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    )),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 90, left: 15),
                        child: Text(
                          "Ingredientes",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w700),
                        ),
                      )),
                  IngredientsList(
                    key: ingredients_key,
                    litems: receita["prods"],
                    props: receita["props"],
                    backgroundColor: backgroundColor,
                  ),
                  Stack(alignment: AlignmentDirectional.center, children: [
                    ButtonsContainer(func: () {
                      if (widget.mine) {
                        setState(() {
                          saved = true;
                        });
                      }
                      main_key.currentState.push(MaterialPageRoute(
                          builder: (context) => PrepareRecipe(
                                id: receita["id"],
                                saved: saved,
                              ))); //        id: widget.id,
                    }),
                    InkWell(
                        onTap: () {
                          if (widget.mine) {
                            setState(() {
                              saved = true;
                            });
                          }
                          main_key.currentState.push(MaterialPageRoute(
                              builder: (context) => PrepareRecipe(
                                    id: receita["id"],
                                    saved: saved,
                                  )));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.local_dining,
                              size: 30,
                            ),
                            Text(
                              "Preparar",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))
                  ])
                ]))));
  }
}

final GlobalKey<ListItemWidget> ingredients_key = GlobalKey();

class IngredientsList extends StatefulWidget {
  IngredientsList({Key key, this.litems, this.props, this.backgroundColor})
      : super(key: key);

  final List litems;
  int props;
  final Color backgroundColor;

  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<IngredientsList> {
  ScrollController _scrollController = new ScrollController();
  void updateDown(bool ups) {
    if (widget.props != 1 && ups) {
      setState(() {
        widget.props--;
        widget.litems.forEach((element) {
          element["quant"] = (element["quant"] / 1.5).round();
        });
      });
    } else {
      setState(() {
        widget.props++;
        widget.litems.forEach((element) {
          element["quant"] = (element["quant"] * 1.5).round();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return Container(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Material(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: BorderSide(color: Colors.black)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    updateDown(true);
                  },
                  child: Center(
                    child: Text(
                      "  -  ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Text("  " + widget.props.toString() + "  ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Material(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: BorderSide(color: Colors.black)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    updateDown(false);
                  },
                  child: Center(
                    child: Text(
                      "  +  ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 20, left: 25),
          shrinkWrap: true,
          itemCount: widget.litems.length,
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Row(children: <Widget>[
                    Text(widget.litems[index]["quant"].toString() + " ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                    Text(widget.litems[index]["type"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                  ]),
                ),
                Text("     " + widget.litems[index]["prod"],
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            );
          },
        ),
      ]));
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Esta receita não contem ingredientes",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
