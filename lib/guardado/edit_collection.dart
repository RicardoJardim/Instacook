import 'package:flutter/material.dart';
import 'package:instacook/guardado/edit_photo.dart';
import 'package:instacook/guardado/edit_recipes.dart';
import 'package:instacook/guardado/main.dart';
import '../main.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/savedService.dart';

class EditCollection extends StatefulWidget {
  EditCollection({Key key, this.id}) : super(key: key);

  final int id;
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  final _auth = AuthService();
  final _savedService = SavedService();
  String _id;
  Future<Map> getColletion() async {
    _id = await _auth.getCurrentUser();
    var litems = await _savedService.getMyBook(_id, widget.id);
    name.text = litems["name"];
    return litems;
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      print("save collection");
      Map map = Map();
      map["image"] = null;
      map["delete"] = deleteRecipe;
      if (imageUrl != null) {
        map["image"] = imageUrl;
      }
      map["name"] = name.text;

      await _savedService.updateColletionImage(_id, widget.id, map);
      main_key.currentState.pop(context);
    }
  }

  String imageUrl;
  List deleteRecipe = [];

  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Editar Livro"),
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
          ],
        ),
        body: FutureBuilder(
            future: getColletion(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                    top: true,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.amber[900], width: 2),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        imageUrl == null
                                            ? snapshot.data["imgUrl"]
                                            : imageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: progress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? progress
                                                          .cumulativeBytesLoaded /
                                                      progress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: InkWell(
                                onTap: () {
                                  main_key.currentState.push(MaterialPageRoute(
                                      builder: (context) => EditPhoto(
                                            id: widget.id,
                                            recipes: snapshot.data["recipes"],
                                            img: snapshot.data["imgUrl"],
                                            name: snapshot.data["name"],
                                            onClickImage: (str) {
                                              setState(() {
                                                imageUrl = str;
                                              });
                                            },
                                          )));
                                },
                                child: Text(
                                  "Alterar Foto do Livro",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            Form(
                              autovalidate: true,
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  _entryField("Nome", name, errorHandlerName),
                                ],
                              ),
                            ),
                            _divider(),
                            _sideButton("Modificar Receitas", Colors.blue, () {
                              main_key.currentState.push(MaterialPageRoute(
                                  builder: (context) => EditRecipes(
                                      id: widget.id,
                                      recipes: snapshot.data["recipes"],
                                      callback: (list) {
                                        deleteRecipe = list;
                                        print(deleteRecipe);
                                      })));
                            }),
                            _divider(),
                            _sideButton("Eliminar Livro", Colors.red,
                                () => eliminarConta()),
                            _divider()
                          ],
                        )));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  final _formKey = GlobalKey<FormState>();
  String errorHandlerName(String value) {
    if (value.isEmpty) {
      return "É obrigatorio ter um nome";
    } else if (value.length < 2) {
      return "Minimo de 2 letras";
    }
    return null;
  }

  Widget _entryField(
      String title, TextEditingController _controller, Function errorHandler) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (value) => errorHandler(value),
          obscureText: false,
          controller: _controller,
          style: TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            labelText: title,
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

  Widget _sideButton(String text, Color cor, Function callback) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          callback();
        },
        child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "$text",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: cor,
                  ),
                ))),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Divider(
        thickness: 1.5,
        height: 4,
      ),
    );
  }

  void eliminarConta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Eliminar Libro"),
          content: new Text("Deseja eliminar o livro " + name.text + " ?"),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                child: new Text("Sim"),
                onPressed: () {
                  print("Eliminar livro");
                  Navigator.of(context).pop();
                  main_key.currentState.pop(context);
                  saved_key.currentState.pop(context);
                  _savedService.deleteColletion(_id, widget.id);
                }),
          ],
          elevation: 24,
        );
      },
    );
  }
}
