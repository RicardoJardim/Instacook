import 'package:flutter/material.dart';
import 'package:instacook/services/auth.dart';
import 'Widget/bezierContainer.dart';
import 'package:instacook/main.dart';
import '../router.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String _errorMsg = "";

  void errorPop(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(error),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
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

  Widget _backButton() {
    return InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          email.clear();
          password.clear();
          username.clear();

          main_key.currentState.pop(context);
        },
        child: Container(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 40,
          ),
        ));
  }

  Widget _entryField(String title, bool isPassword,
      TextEditingController _controller, Function errorHandler) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) => errorHandler(value),
            autofocus: false,
            obscureText: isPassword,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.grey[200],
              filled: true,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: Colors.amber[800], width: 2),
              ),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 1)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: Colors.amber[800], width: 2),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: RaisedButton(
          elevation: 7,
          splashColor: Colors.amber,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Colors.amber[800],
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              var res = await _auth.registEmailPassword(
                  email.text, password.text, username.text);
              print(res);
              if (res) {
                main_key.currentState.popAndPushNamed(Routes.mainapp);
              } else {
                errorPop("Email invalido");
              }
            }
          },
          textColor: Colors.white,
          child: Text(
            'Registar',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ));
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Já tem uma conta ?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              email.clear();
              password.clear();
              username.clear();
              main_key.currentState.pop(context);
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.amber[800],
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField("Username", false, username, errorHandlerUsername),
          _entryField("Email id", false, email, errorHandlerEmail),
          _entryField("Password", true, password, errorHandlerPassword),
        ],
      ),
    );
  }

  String errorHandlerUsername(String value) {
    if (value.length < 6) {
      return "Username deve conter pelo menos 6 caracteres";
    } else if (value.length > 16) {
      return "Username não deve conter mais de 16 caracteres";
    }
    return null;
  }

  String errorHandlerEmail(String value) {
    if (value.isEmpty) {
      return "Por favor insira um email";
    } else if (!value.contains('@') || !value.contains('.')) {
      return "Email mal formatado";
    }
    return null;
  }

  String errorHandlerPassword(String value) {
    if (value.isEmpty) {
      return "Por favor insira uma password";
    } else if (value.length < 6) {
      return "Password inválida";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/instacook_logo.png",
                  scale: 4,
                ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _loginAccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .16,
              right: -MediaQuery.of(context).size.width * .45,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
