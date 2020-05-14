import 'package:flutter/material.dart';
import 'package:instacook/guardado/main.dart';
import 'package:instacook/perfil/change_pass.dart';
import 'package:instacook/photo_picker.dart';

import '../main.dart';
import '../router.dart';

class EditCollection extends StatefulWidget {
  EditCollection({Key key, this.id}) : super(key: key);

  final int id;
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  Map getLista2(int id) {
    var collection = new Map<String, dynamic>();

    collection = {
      "id": id,
      "photo":
          'https://nit.pt/wp-content/uploads/2018/07/95915588dd8f97db9b5bedd24ea068a5-754x394.jpg',
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
    name.text = collection["name"];

    super.initState();
  }

  void save() {
    print("send collection");

    print(collection);

    main_key.currentState.pop(context);
  }

  Map<String, dynamic> collection;
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
            // overflow menu
          ],
        ),
        body: SafeArea(
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
                            child: ClipOval(
                              child: Image.network(
                                collection["photo"],
                                fit: BoxFit.cover,
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
                          /* main_key.currentState.push(MaterialPageRoute(
                              builder: (context) => PhotoPicker(
                                    sendPicture: (image) {
                                      print(image);
                                      print("Send to firebase");
                                    },
                                  ))); */
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
                    _entryField("Nome", name),
                    _divider(),
                    _sideButton("Modificar Receitas", Colors.blue, () {
                      /*  main_key.currentState.push(MaterialPageRoute(
                          builder: (context) => ChangePassword())); */
                    }),
                    _divider(),
                    _sideButton(
                        "Eliminar Livro", Colors.red, () => eliminarConta()),
                    _divider(),
                  ],
                ))));
  }

  Widget _entryField(String title, TextEditingController _controller) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
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
          content:
              new Text("Deseja eliminar o livro " + collection["name"] + " ?"),
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
                }),
          ],
          elevation: 24,
        );
      },
    );
  }
}
