import 'package:flutter/material.dart';
import 'package:instacook/perfil/change_pass.dart';
import 'package:instacook/photo_picker.dart';

import '../main.dart';
import '../router.dart';

class ChangeProfile extends StatefulWidget {
  ChangeProfile({Key key}) : super(key: key);

  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  Map getLista2() {
    var profile = new Map<String, dynamic>();

    profile = {
      "id": 1,
      "username": "Diana C. Faria",
      "pro": false,
      "photo": 'https://picsum.photos/250?image=9',
      "email": "dciasojd@hotmail.com",
    };
    return profile;
  }

  void initState() {
    profile = getLista2();
    email.text = profile["email"];
    username.text = profile["username"];

    super.initState();
  }

  void save() {
    print("send profile");

    print(profile);

    main_key.currentState.pop(context);
  }

  Map<String, dynamic> profile;
  final email = TextEditingController();
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Editar Perfil"),
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
                                profile["photo"],
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
                          main_key.currentState.push(MaterialPageRoute(
                              builder: (context) => PhotoPicker(
                                    textTitle: "Alterar foto de perfil",
                                    sendPicture: (image) {
                                      print(image);
                                      print("Send to firebase");
                                    },
                                  )));
                        },
                        child: Text(
                          "Alterar Foto de Perfil",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    _entryField("Nome", username),
                    _entryField("Email", email),
                    _divider(),
                    _pro(profile["pro"]),
                    _divider(),
                    _sideButton("Modificar Password", Colors.blue, () {
                      main_key.currentState.push(MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                    }),
                    _divider(),
                    _sideButton(
                        "Eliminar Conta", Colors.red, () => eliminarConta()),
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

  Widget _pro(bool pro) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          if (!pro) {
            print("mudar conta");
          } else {
            print("sair conta");
          }
        },
        child: Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: pro
                  ? Text(
                      "Requisitar conta normal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    )
                  : Text(
                      "Requisitar conta profissional",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
            )),
      ),
    );
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
          title: new Text("Eliminar conta"),
          content: new Text("Deseja eliminar a sua conta?"),
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
              onPressed: () {
                print("Eliminar conta");
                Navigator.of(context).pop();
                main_key.currentState
                    .popUntil((r) => r.settings.name == Routes.login);
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }
}
