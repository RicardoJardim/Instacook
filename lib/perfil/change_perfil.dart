import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instacook/models/User.dart';
import 'package:instacook/perfil/change_pass.dart';
import 'package:instacook/photo_picker.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/userService.dart';

import '../main.dart';
import '../router.dart';

class ChangeProfile extends StatefulWidget {
  ChangeProfile({Key key, this.rebuild}) : super(key: key);

  final Function rebuild;
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _auth = AuthService();
  final _userService = userService();

  final email = TextEditingController();
  final username = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _id;
  File _selectedFile;

  Future<User> getUser() async {
    _id = await _auth.getCurrentUser();
    var users = await _userService.getMyUser(_id);
    email.text = users.email;
    username.text = users.username;
    return users;
  }

  void save(String id) async {
    print("send profile");
    Map _map = new Map();
    _map["email"] = email.text;
    _map["username"] = username.text;
    if (_selectedFile != null) {
      _map["image"] = _selectedFile;
    }

    await _userService.updateMyUserData(id, _map);
    main_key.currentState.pop(context);
    widget.rebuild();
  }

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
                if (_formKey.currentState.validate()) {
                  save(_id);
                }
              },
            ),
            // overflow menu
          ],
        ),
        body: FutureBuilder(
            future: getUser(),
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
                                    child: ClipOval(
                                      child: _selectedFile != null
                                          ? Image.file(
                                              _selectedFile,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              snapshot.data.imgUrl,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (context, child, progress) {
                                                if (progress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                      builder: (context) => PhotoPicker(
                                            textTitle: "Alterar foto de perfil",
                                            sendPicture: (image) {
                                              setState(() {
                                                _selectedFile = image;
                                              });
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
                            _formWidget(),
                            _divider(),
                            _pro(snapshot.data.proUser),
                            _divider(),
                            _sideButton("Modificar Password", Colors.blue, () {
                              main_key.currentState.push(MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                            }),
                            _divider(),
                            _sideButton("Eliminar Conta", Colors.red,
                                () => eliminarConta()),
                            _divider(),
                          ],
                        )));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget _entryField(
      String title, TextEditingController _controller, Function errorHandler) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) => errorHandler(value),
                obscureText: false,
                autofocus: false,
                focusNode: FocusNode(canRequestFocus: false),
                controller: _controller,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  labelText: title,
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.amber[800], width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber[800], width: 2),
                  ),
                ),
              )
            ]));
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
                _userService.deleteMyUserData(_id);
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

  Widget _formWidget() {
    print("sdasd");
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _entryField("Nome", username, errorHandlerUsername),
          _entryField("Email", email, errorHandlerEmail),
        ],
      ),
    );
  }

  String errorHandlerEmail(String value) {
    if (value.isEmpty) {
      return "Por favor insira um email";
    } else if (!value.contains('@') || !value.contains('.')) {
      return "Email mal formatado";
    }
    return null;
  }

  String errorHandlerUsername(String value) {
    if (value.length < 6) {
      return "Username deve conter pelo menos 6 caracteres";
    } else if (value.length > 16) {
      return "Username não deve conter mais de 16 caracteres";
    }
    return null;
  }
}
