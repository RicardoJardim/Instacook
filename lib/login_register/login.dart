import 'package:flutter/material.dart';
import 'package:instacook/main.dart';
import 'package:instacook/services/auth.dart';
import 'Widget/bezierContainer.dart';
import '../router.dart';
import 'dart:core';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    email.dispose();
    password.dispose();
    super.dispose();
    //tadeu1@live.com.pt
  }

  Widget _entryField(String title, bool isPassword,
      TextEditingController _controller, bool focus) {
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
            autofocus: focus,
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
          onPressed: () async {
            if ((email.text.trim()).isNotEmpty && password.text.isNotEmpty) {
            
              dynamic result = await _auth.signInEmailPassword(email.text, password.text);
              if(result == null){
                print("Error Login");
              }
              else{
                print("UID: "+result.uid);
                main_key.currentState.pushNamed(Routes.mainapp);
              }
            }
          },
          textColor: Colors.white,
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('ou'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _googleButton() {
    return SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          elevation: 7,
          splashColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Colors.blue[600],
          onPressed: () {
            main_key.currentState.pushNamed(Routes.mainapp);
          },
          textColor: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/images/google.png",
                  width: 50,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('Login com o Google',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ));
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Ainda não tem uma conta ?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              main_key.currentState.pushNamed(Routes.register);

              email.clear();
              password.clear();
            },
            child: Text(
              'Registo',
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

  // Widget _title() {
  //   return Container(
  //     child: AssetImage("assets/instacool_logo.png"),
  //   );
  // }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", false, email, false),
        _entryField("Password", true, password, false)
      ],
    );
  }

  Widget _inputErrorMsg (String errorMsg){
    return Text(
      errorMsg,
      style: TextStyle(
        color: Colors.red,
        
      ),
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
                Image.asset(
                  "assets/images/instacook_logo.png",
                  scale: 3,
                  ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                _divider(),
                _googleButton(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _createAccountLabel(),
          ),
          Positioned(
              top: -MediaQuery.of(context).size.height * .16,
              right: -MediaQuery.of(context).size.width * .45,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
