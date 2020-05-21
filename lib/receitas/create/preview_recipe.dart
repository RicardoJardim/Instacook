import 'package:flutter/material.dart';
import 'package:instacook/receitas/Widget/ButtonsContainer.dart';
import 'package:instacook/receitas/create/preview_prepare.dart';

import '../../main.dart';

class PreviewRecipe extends StatefulWidget {
  PreviewRecipe({Key key, this.receita}) : super(key: key);

  final Map receita;
  _PreviewRecipelState createState() => _PreviewRecipelState();
}

class _PreviewRecipelState extends State<PreviewRecipe> {
  Map getUser(int id) {
    var user = new Map<String, dynamic>();
    user = {
      "id": id,
      "username": "Ricardo Lucas",
      "pro": true,
      "image":
          "https://images2.minutemediacdn.com/image/upload/c_crop,h_1126,w_2000,x_0,y_181/f_auto,q_auto,w_1100/v1554932288/shape/mentalfloss/12531-istock-637790866.jpg",
    };
    return user;
  }

  @override
  void initState() {
    user = getUser(1);
    backgroundColor = Colors.amber[600];
    super.initState();
  }

  Map<String, dynamic> user = new Map<String, dynamic>();
  bool liked;
  bool saved;
  Color backgroundColor;

  void saveRecipe() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Finalizar receita"),
          content: new Text(widget.receita["id"] != null
              ? "Deseja guardar a receita editada?"
              : "Deseja guardar a receita criada?"),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlatButton(
                child: new Text(
                  "Eliminar",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  main_key.currentState.pop(context);
                  main_key.currentState.pop(context);
                },
                textColor: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlatButton(
                child: new Text(
                  "Guardar",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (widget.receita["id"] == null) {
                    print("guardar " + widget.receita.toString());
                  } else {
                    print("editar " + widget.receita.toString());
                  }
                  main_key.currentState.pop(context);
                  main_key.currentState.pop(context);
                },
                textColor: Colors.green,
              ),
            ),
          ],
          elevation: 24,
        );
      },
    );
  }

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
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                enableFeedback: true,
                tooltip: "confirmar",
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 34,
                ),
                onPressed: () {
                  print("concluir");
                  saveRecipe();
                })
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
                          widget.receita["name"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w700),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
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
                            child: widget.receita["id"] == null
                                ? Image.file(
                                    widget.receita["image"],
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  )
                                : Image.network(
                                    widget.receita["image"],
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
                                  ))),
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text(
                          " pessoas gostaram desta receita",
                          style: TextStyle(fontSize: 14),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Stack(children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      NetworkImage(user["image"]))),
                          user["pro"]
                              ? Positioned(
                                  right: -3,
                                  bottom: -3,
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {},
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
                              onTap: () {},
                              child: Text(
                                user["username"],
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
                      widget.receita["description"],
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
                              "  " + widget.receita["time"],
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
                              "  " + widget.receita["type"],
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
                            "  " + widget.receita["difficulty"],
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
                      onPressed: () {},
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
                    litems: widget.receita["prods"],
                    props: widget.receita["props"],
                    backgroundColor: backgroundColor,
                  ),
                  Stack(alignment: AlignmentDirectional.center, children: [
                    ButtonsContainer(func: () {
                      main_key.currentState.push(MaterialPageRoute(
                          builder: (context) => PreviewPrepare(
                                receita: widget.receita,
                              )));
                    }),
                    InkWell(
                        onTap: () {
                          main_key.currentState.push(MaterialPageRoute(
                              builder: (context) => PreviewPrepare(
                                    receita: widget.receita,
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
                              "Ver Preparar",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))
                  ])
                ]))));
  }
}

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
                  onTap: () {},
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
                  onTap: () {},
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
