import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instacook/photo_picker.dart';
import 'package:instacook/receitas/create/add_ingre.dart';
import 'package:instacook/receitas/create/add_step.dart';
import 'package:instacook/receitas/create/preview_recipe.dart';

import '../../main.dart';

class CreateRecipe extends StatefulWidget {
  CreateRecipe({Key key, this.editRecipe}) : super(key: key);

  final Map editRecipe;
  _CreateRecipelState createState() => _CreateRecipelState();
}

class _CreateRecipelState extends State<CreateRecipe> {
  @override
  void initState() {
    if (widget.editRecipe == null) {
      receita = new Map<String, dynamic>();
    } else {
      receita = widget.editRecipe;
      privacy = widget.editRecipe["privacy"];
      dif = widget.editRecipe["difficulty"];
      prods = widget.editRecipe["prods"];
      stepsRecipe = getSteps(widget.editRecipe["id"]);
      name.text = widget.editRecipe["name"];
      type.text = widget.editRecipe["type"];
      description.text = widget.editRecipe["description"];
      time.text = widget.editRecipe["time"];
      props.text = widget.editRecipe["props"].toString();
      imageUrl = widget.editRecipe["image"];
    }
    steps = [1, 2, 3, 4, 5];
    super.initState();
  }

  List getSteps(int id) {
    //PEsquisa na bd pelo id
    return [
      {
        "prods": [
          {"quant": 200, "type": "mg", "prod": "leite"},
          {"quant": 100, "type": "mg", "prod": "merda"},
          {"quant": 200, "type": "mg", "prod": "leite"},
          {"quant": 100, "type": "mg", "prod": "merda"},
        ],
        "description":
            " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sdasd asdas d asd asd a a uysgd aksb dkjahs kjdhn akjsdh kjash dkjahwsjkdh akjsdh ksjha kjdah kdjsah kjash ",
        "image":
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg"
      },
      {
        "prods": [
          {"quant": 200, "type": "mg", "prod": "leite"},
          {"quant": 100, "type": "mg", "prod": "merda"},
        ],
        "description":
            " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd as dasd ",
        "image": " ",
      },
      {
        "prods": [
          {"quant": 500, "type": "mg", "prod": "manteiga"},
          {"quant": 200, "type": "mg", "prod": "merda"},
        ],
        "description":
            " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd as dasdasd as dasdas d",
        "image":
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg"
      },
      {
        "prods": [
          {"quant": 800, "type": "mg", "prod": "leadsdite"},
          {"quant": 700, "type": "mg", "prod": "cxa"},
        ],
        "description":
            " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd asda sda  s asd",
        "image": " ",
      },
    ];
  }

  Map<String, dynamic> receita;
  List steps;
  int indexs = 0;
  double progvalue = 0.20;
  ScrollController _controller = ScrollController();

  _animateToIndex(i) =>
      _controller.animateTo(MediaQuery.of(context).size.width * i,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  //Recipe
  bool privacy = false;
  String dif = "";
  List prods = [];
  List stepsRecipe = [];
  String imageUrl = "";
  //Files
  File _selectedFile;

  //text controllers
  final name = TextEditingController();
  final type = TextEditingController();
  final description = TextEditingController();
  final time = TextEditingController();
  final props = TextEditingController();

  void saveRecipe() {
    print(receita);
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => PreviewRecipe(receita: receita)));
  }

  void moveToNext() {
    setState(() {
      progvalue += 0.20;
    });
    indexs++;
    _animateToIndex(indexs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.editRecipe == null ? "Criar Receita" : "Editar Receita",
            style: TextStyle(fontSize: 24),
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 34,
            ),
            onPressed: () => main_key.currentState.pop(context),
          ),
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: LinearProgressIndicator(
                      value: progvalue,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.amber[800]),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          Widget childs;
                          switch (index) {
                            case 0:
                              childs = _page1();
                              break;
                            case 1:
                              childs = _page2();
                              break;
                            case 2:
                              childs = _page3();
                              break;
                            case 3:
                              childs = _page4();
                              break;
                            case 4:
                              childs = _page5();
                              break;
                          }
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: childs,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonTheme(
                              minWidth: 140.0,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: Colors.grey, width: 2)),
                                padding: EdgeInsets.all(20),
                                splashColor: Colors.amber[800],
                                color: Colors.white,
                                onPressed: () {
                                  if (indexs != 0) {
                                    setState(() {
                                      progvalue -= 0.20;
                                    });
                                    indexs--;
                                    _animateToIndex(indexs);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.arrow_back),
                                    Text(
                                      " Anterior",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )),
                          ButtonTheme(
                              minWidth: 140.0,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: Colors.amber[800], width: 2)),
                                padding: EdgeInsets.all(20),
                                splashColor: Colors.amber[800],
                                color: Colors.white,
                                onPressed: () {
                                  if (indexs != (steps.length)) {
                                    switch (indexs) {
                                      case 0:
                                        if (name.text != "") {
                                          receita["name"] = name.text;
                                          if (widget.editRecipe == null &&
                                              _selectedFile != null) {
                                            receita["image"] = _selectedFile;
                                            moveToNext();
                                          } else if (widget.editRecipe !=
                                              null) {
                                            if (_selectedFile != null) {
                                              receita["image"] = _selectedFile;
                                              moveToNext();
                                            } else {
                                              receita["image"] =
                                                  receita["image"];
                                              moveToNext();
                                            }
                                          }
                                        }
                                        break;
                                      case 1:
                                        if (type.text != "" &&
                                            description.text != "") {
                                          receita["type"] = type.text;
                                          receita["description"] =
                                              description.text;
                                          receita["privacy"] = privacy;
                                          moveToNext();
                                        }
                                        break;
                                      case 2:
                                        if (props.text != "" &&
                                            time.text != "" &&
                                            dif != "") {
                                          receita["time"] = time.text;
                                          receita["props"] =
                                              int.parse(props.text);
                                          receita["difficulty"] = dif;
                                          moveToNext();
                                        }
                                        break;
                                      case 3:
                                        receita["prods"] = prods;
                                        moveToNext();
                                        break;
                                      case 4:
                                        if (stepsRecipe.length != 0) {
                                          receita["steps"] = stepsRecipe;
                                          setState(() {
                                            progvalue += 0.20;
                                          });
                                          saveRecipe();
                                        }
                                        break;
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Seguinte ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.amber[800]),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.amber[800],
                                    )
                                  ],
                                ),
                              ))
                        ]),
                  )
                ]))));
  }

  Widget _page1() {
    return Column(
      children: <Widget>[
        _entryField("Nome da receita", "Bolo de Banana", name),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Adicionar foto da receita",
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height - 380,
                    child: InkWell(
                      onTap: () {
                        main_key.currentState.push(MaterialPageRoute(
                            builder: (context) => PhotoPicker(
                                  textTitle: "Foto da receita",
                                  round: false,
                                  sendPicture: (image) {
                                    setState(() {
                                      _selectedFile = image;
                                    });
                                  },
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: getImageWidget(),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _page2() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _entryField("Tipo de Receita", "Carne", type),
          _entryField("Descrição", "Esta receita ....", description),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Privacidade",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "Tornar a receita privada",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Transform.scale(
                    scale: 1,
                    child: Switch(
                        activeTrackColor: Colors.amber[300],
                        activeColor: Colors.amber[800],
                        value: privacy,
                        onChanged: (bool value) {
                          setState(() {
                            privacy = value;
                          });
                        }))
              ],
            ),
          ),
        ]);
  }

  Widget _page3() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _entryField("Proporções", "1 pessoa", props,
              inputType: TextInputType.number),
          _entryField(
            "Tempo de Preparação",
            "5-10 minutos",
            time,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
            child: Text("Dificuldade",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w800)),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: DiffButtons(
                init: widget.editRecipe == null
                    ? ""
                    : widget.editRecipe["difficulty"],
                callback: (str) {
                  dif = str;
                },
              ))
        ]); //MANDAR
  }

  Widget _page4() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Ingredientes",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w800)),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: FlatButton(
                      onPressed: () {
                        main_key.currentState.push(MaterialPageRoute(
                            builder: (context) => AddIngridient(
                                  callback: (map) {
                                    setState(() {
                                      prods.add(map);
                                    });
                                  },
                                )));
                      },
                      autofocus: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.amber[800], width: 2)),
                      padding: EdgeInsets.all(15),
                      splashColor: Colors.amber[800],
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Adicionar Ingrediente ",
                            style: TextStyle(
                              color: Colors.amber[800],
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.amber[800],
                          ),
                        ],
                      ))),
            ),
            prods.length != 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 325,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          primary: true,
                          itemCount: prods.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        prods[index]["quant"].toString() +
                                            " " +
                                            prods[index]["prod"].toString() +
                                            " " +
                                            prods[index]["type"].toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            print("remove");
                                            setState(() {
                                              prods.removeAt(index);
                                            });
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : Text("")
          ]),
    );
  }

  Widget _page5() {
    // ACABAR
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Passos",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w800)),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: FlatButton(
                      onPressed: () {
                        main_key.currentState.push(MaterialPageRoute(
                            builder: (context) => AddStep(
                                  ingr: prods,
                                  callback: (map) {
                                    print(map);
                                    setState(() {
                                      stepsRecipe.add(map);
                                    });
                                  },
                                )));
                      },
                      autofocus: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.amber[800], width: 2)),
                      padding: EdgeInsets.all(15),
                      splashColor: Colors.amber[800],
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Adicionar Passo ",
                            style: TextStyle(
                              color: Colors.amber[800],
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.amber[800],
                          ),
                        ],
                      ))),
            ),
            stepsRecipe.length != 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 325,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          primary: true,
                          itemCount: stepsRecipe.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              getImageForStep(index),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                width: 200,
                                                height: 80,
                                                child: Text(
                                                  "Descrição: " +
                                                      stepsRecipe[index]
                                                          ["description"],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                print("remove");
                                                setState(() {
                                                  stepsRecipe.removeAt(index);
                                                });
                                              })
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            primary: false,
                                            itemCount: stepsRecipe[index]
                                                    ["prods"]
                                                .length,
                                            itemBuilder: (context, indexs) {
                                              return Text(
                                                " - " +
                                                    stepsRecipe[index]["prods"]
                                                            [indexs]["quant"]
                                                        .toString() +
                                                    " " +
                                                    stepsRecipe[index]["prods"]
                                                            [indexs]["prod"]
                                                        .toString() +
                                                    " " +
                                                    stepsRecipe[index]["prods"]
                                                            [indexs]["type"]
                                                        .toString(),
                                                style: TextStyle(fontSize: 14),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : Text("")
          ]),
    );
  }

  Widget _entryField(
      String title, String example, TextEditingController _controller,
      {inputType: TextInputType.text}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          keyboardType: inputType,
          autofocus: false,
          focusNode: FocusNode(canRequestFocus: false),
          controller: _controller,
          style: TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            labelText: title,
            helperText: "Ex: " + example,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber[800], width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber[800], width: 2),
            ),
          ),
        ));
  }

  Widget getImageForStep(index) {
    if (widget.editRecipe == null) {
      if (stepsRecipe[index]["image"] == "") {
        return Text("");
      } else {
        return Image.file(
          stepsRecipe[index]["image"],
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        );
      }
    } else {
      if (stepsRecipe[index]["image"] == "") {
        return Text("");
      } else if (stepsRecipe[index]["image"] is String) {
        return Image.network(
          stepsRecipe[index]["image"],
          height: 80,
          width: 80,
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
        );
      } else {
        return Image.file(
          stepsRecipe[index]["image"],
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        );
      }
    }
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        fit: BoxFit.cover,
      );
    } else {
      if (widget.editRecipe == null) {
        return Image.asset(
          "assets/placeholder.jpg",
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          receita["image"],
          fit: BoxFit.cover,
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
        );
      }
    }
  }
}

class DiffButtons extends StatefulWidget {
  DiffButtons({Key key, this.callback, this.init: ""}) : super(key: key);

  final ValueChanged<String> callback;
  final String init;
  _DiffButtonsState createState() => _DiffButtonsState();
}

class _DiffButtonsState extends State<DiffButtons> {
  @override
  void initState() {
    if (widget.init != "") {
      if (widget.init == "Fácil") {
        changeState(1);
      } else if (widget.init == "Médio") {
        changeState(2);
      } else {
        changeState(3);
      }
    }
    super.initState();
  }

  Map<String, dynamic> buttons = {
    "btn1": [Colors.black, Colors.white],
    "btn2": [Colors.black, Colors.white],
    "btn3": [Colors.black, Colors.white],
  };

  void changeState(int id) {
    buttons.forEach((key, value) {
      print(value);
      buttons[key] = [Colors.black, Colors.white];
    });
    setState(() {
      buttons["btn" + id.toString()] = [Colors.white, Colors.amber[800]];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
            minWidth: 100.0,
            child: FlatButton(
                onPressed: () {
                  widget.callback("Fácil");
                  changeState(1);
                },
                autofocus: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.amber[800], width: 2)),
                padding: EdgeInsets.all(15),
                splashColor: Colors.amber[800],
                color: buttons["btn1"][1],
                child: Text(
                  "Fácil",
                  style: TextStyle(color: buttons["btn1"][0]),
                ))),
        ButtonTheme(
            minWidth: 100.0,
            child: FlatButton(
                onPressed: () {
                  widget.callback("Médio");
                  changeState(2);
                },
                autofocus: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.amber[800], width: 2)),
                padding: EdgeInsets.all(15),
                splashColor: Colors.amber[800],
                color: buttons["btn2"][1],
                child: Text(
                  "Médio",
                  style: TextStyle(color: buttons["btn2"][0]),
                ))),
        ButtonTheme(
            minWidth: 100.0,
            child: FlatButton(
                onPressed: () {
                  widget.callback("Difícil");
                  changeState(3);
                },
                autofocus: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.amber[800], width: 2)),
                padding: EdgeInsets.all(15),
                splashColor: Colors.amber[800],
                color: buttons["btn3"][1],
                child: Text(
                  "Difícil",
                  style: TextStyle(color: buttons["btn3"][0]),
                ))),
      ],
    );
  }
}
