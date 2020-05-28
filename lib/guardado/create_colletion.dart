import 'package:flutter/material.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/savedService.dart';

class CreateColletion extends StatefulWidget {
  CreateColletion({Key key, this.onPop}) : super(key: key);

  final ValueChanged<BuildContext> onPop;

  _CreateColletionState createState() => _CreateColletionState();
}

class _CreateColletionState extends State<CreateColletion> {
  final colletionName = TextEditingController();
  final _auth = AuthService();
  final _savedService = SavedService();

  Future createaColletion() async {
    String _id = await _auth.getCurrentUser();
    var result = await _savedService.addToColletion(_id, colletionName.text);
    print(colletionName.text);
    if (result) {
      widget.onPop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 50,
            ),
            onPressed: () => widget.onPop(context),
          ),
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Crie um novo livro!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: 240,
                        child: Text(
                          "Podes editar o teu livro quando quiseres!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 25, right: 25),
                      child: _entryField("Nome", colletionName),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: FlatButton(
                        splashColor: Colors.amber,
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 120, right: 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.amber[800],
                        onPressed: () {
                          if (colletionName.text != " " &&
                              colletionName.text != "") {
                            createaColletion();
                          }
                        },
                        child: Text(
                          'CRIAR',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ))));
  }

  Widget _entryField(String title, TextEditingController _controller) {
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
            autofocus: true,
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
}
