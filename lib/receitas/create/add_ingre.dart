import 'package:flutter/material.dart';

import '../../main.dart';

class AddIngridient extends StatefulWidget {
  AddIngridient({Key key, this.callback}) : super(key: key);

  final ValueChanged<Map> callback;
  _AddIngridientlState createState() => _AddIngridientlState();
}

class _AddIngridientlState extends State<AddIngridient> {
  final ingr = TextEditingController();
  final quant = TextEditingController();
  final unit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Ingrediente",
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
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              enableFeedback: true,
              tooltip: "confirmar",
              icon: Icon(
                Icons.check,
                color: Colors.amber[800],
                size: 34,
              ),
              onPressed: () {
                if (ingr.text != "") {
                  widget.callback({
                    "quant": quant.text,
                    "prod": ingr.text,
                    "type": unit.text
                  });
                  main_key.currentState.pop(context);
                }
              },
            ),
          ],
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _entryField("Ingrediente", "Agua", ingr),
                    _entryField("Quantidade", "500", quant),
                    _entryField("Unidade", "mL", unit)
                  ],
                ))));
  }

  Widget _entryField(
    String title,
    String example,
    TextEditingController _controller,
  ) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          autofocus: false,
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
}
