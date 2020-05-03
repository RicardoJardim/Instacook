import 'package:flutter/material.dart';

import '../main.dart';

class SeeRecipe extends StatefulWidget {
  SeeRecipe({Key key, this.id}) : super(key: key);

  final String id;
  _SeeRecipelState createState() => _SeeRecipelState();
}

class _SeeRecipelState extends State<SeeRecipe> {
  Map getLista2(String id) {
    var receita = new Map<String, dynamic>();

    receita = {
      "id": id,
      "name": "Pizza de Frango",
      "props": 2,
      "prods": [
        {"quant": "250 mg", "prod": "leite", "done": true},
        {"quant": "300 mg", "prod": "merda", "done": true},
        {"quant": "300 mg", "prod": "merda", "done": false},
        {"quant": "300 mg", "prod": "merda", "done": true},
      ]
    };
    return receita;
  }

  Map<String, dynamic> receita = new Map<String, dynamic>();

  @override
  Widget build(BuildContext context) {
    @override
    initState() {
      receita = getLista2(widget.id);
    }

    initState();
    print(receita["id"]);

    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        main_key.currentState.pop(context);
                      },
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 50,
                        ),
                      )),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 90, left: 15),
                    child: Text(
                      receita["name"],
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                  )),
            ])));
  }
}
