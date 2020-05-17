import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instacook/photo_picker.dart';
import 'package:instacook/receitas/create/add_ingre.dart';
import 'package:instacook/receitas/create/add_step.dart';
import 'package:instacook/receitas/create/preview_recipe.dart';

import '../../main.dart';

class CreateRecipe extends StatefulWidget {
  CreateRecipe({Key key}) : super(key: key);

  _CreateRecipelState createState() => _CreateRecipelState();
}

class _CreateRecipelState extends State<CreateRecipe> {
  @override
  void initState() {
    receita = new Map<String, dynamic>();
    steps = [1, 2, 3, 4, 5];
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Criar Receita",
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
                                        if (name.text != "" &&
                                            _selectedFile != null) {
                                          receita["name"] = name.text;
                                          receita["image"] = _selectedFile;
                                          print(receita);
                                          setState(() {
                                            progvalue += 0.20;
                                          });
                                          indexs++;
                                          _animateToIndex(indexs);
                                        }
                                        break;
                                      case 1:
                                        if (type.text != "" &&
                                            description.text != "") {
                                          receita["type"] = type.text;
                                          receita["description"] =
                                              description.text;
                                          receita["privacy"] = privacy;
                                          setState(() {
                                            progvalue += 0.20;
                                          });
                                          indexs++;
                                          _animateToIndex(indexs);
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
                                          setState(() {
                                            progvalue += 0.20;
                                          });
                                          indexs++;
                                          _animateToIndex(indexs);
                                        }
                                        break;
                                      case 3:
                                        receita["prods"] = prods;
                                        setState(() {
                                          progvalue += 0.20;
                                        });
                                        indexs++;
                                        _animateToIndex(indexs);

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
                    width: MediaQuery.of(context).size.width - 100,
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
                callback: (str) {
                  dif = str;
                },
              ))
        ]);
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
                                        prods[index]["quant"] +
                                            " " +
                                            prods[index]["prod"] +
                                            " " +
                                            prods[index]["type"],
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
                                              stepsRecipe[index]["image"] == ""
                                                  ? Text("")
                                                  : Image.file(
                                                      _selectedFile,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                    ),
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
                                            primary: true,
                                            itemCount: stepsRecipe[index]
                                                    ["prods"]
                                                .length,
                                            itemBuilder: (context, indexs) {
                                              return Text(
                                                " - " +
                                                    stepsRecipe[index]["prods"]
                                                        [indexs]["quant"] +
                                                    " " +
                                                    stepsRecipe[index]["prods"]
                                                        [indexs]["prod"] +
                                                    " " +
                                                    stepsRecipe[index]["prods"]
                                                        [indexs]["type"],
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

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        fit: BoxFit.cover,
      );
    }
  }
}

class DiffButtons extends StatefulWidget {
  DiffButtons({Key key, this.callback}) : super(key: key);

  final ValueChanged<String> callback;
  _DiffButtonsState createState() => _DiffButtonsState();
}

class _DiffButtonsState extends State<DiffButtons> {
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
