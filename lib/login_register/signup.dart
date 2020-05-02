import 'package:flutter/material.dart';
import 'Widget/bezierContainer.dart';
import '../router.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  Widget _backButton() {
    return InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          email.clear();
          password.clear();
          username.clear();
          Navigator.pop(context);
        },
        child: Container(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 40,
          ),
        ));
  }

  Widget _entryField(
      String title, bool isPassword, TextEditingController _controller) {
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
          TextField(
            autofocus: false,
            obscureText: isPassword,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.grey[200],
              filled: true,
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
          onPressed: () {
            if ((email.text.trim()).isNotEmpty &&
                password.text.isNotEmpty &&
                username.text.isNotEmpty) {
              print(email.text.trim());
              print(password.text);
              print(username.text);
              Navigator.popAndPushNamed(context, Routes.mainapp);
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
              Navigator.pop(context);
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: TextStyle(fontSize: 46, fontWeight: FontWeight.w700),
          children: [
            TextSpan(
              text: 'Insta',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'cook',
              style: TextStyle(color: Colors.amber[800], fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username", false, username),
        _entryField("Email id", false, email),
        _entryField("Password", true, password),
      ],
    );
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
                _title(),
                SizedBox(
                  height: 10,
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
