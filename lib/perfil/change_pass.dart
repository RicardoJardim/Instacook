import 'package:flutter/material.dart';
import 'package:instacook/services/auth.dart';

import '../main.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();

  void save() async {
    String text = "";

    if (passwordActual.text == "" ||
        passwordNew.text == "" ||
        passwordNewTwo.text == "") {
      text += "Todos os campos são obrigatórios \n";
    }
    if (passwordNewTwo.text != passwordNew.text) {
      text += "As passwords têm de ser iguais \n";
    }
    if (passwordNew.text == passwordActual.text) {
      text += "A nova password tem de ser diferente da atual";
    }

    if (text == "") {
      print(passwordNew.text);
      await _auth.changePassword(passwordNew.text);
      main_key.currentState.pop(context);
    } else {
      popUp(text);
    }
  }

  Map<String, dynamic> profile;
  final passwordActual = TextEditingController();
  final passwordNew = TextEditingController();
  final passwordNewTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Editar Password"),
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
                  save();
                }
              },
            ),
            // overflow menu
          ],
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical, child: _formWidget())));
  }

  Widget _entryField(
      String title, TextEditingController _controller, Function errorHandler) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (value) => errorHandler(value),
          obscureText: true,
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

  Widget _formWidget() {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _entryField("Password atual", passwordActual, errorHandlerPassword),
          _entryField("Nova password", passwordNew, errorHandlerPassword),
          _entryField(
              "Confirmar password", passwordNewTwo, errorHandlerPassword),
        ],
      ),
    );
  }

  String errorHandlerPassword(String value) {
    if (value.isEmpty) {
      return "Por favor insira uma password";
    } else if (value.length < 6) {
      return "Password inválida";
    }
    return null;
  }

  void popUp(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(
            content,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "OK",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }
}
