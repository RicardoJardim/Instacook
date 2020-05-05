import 'package:flutter/material.dart';

import '../main.dart';

class PrepareRecipe extends StatefulWidget {
  PrepareRecipe({Key key, this.id, this.saved}) : super(key: key);

  final int id;
  final String saved;
  _PrepareRecipelState createState() => _PrepareRecipelState();
}

class _PrepareRecipelState extends State<PrepareRecipe> {
  Map getLista2(int id) {
    var receita = new Map<String, dynamic>();

    receita = {
      "id": id,
      "steps": [
        {
          "prods": [
            {"quant": 200, "type": "mg", "prod": "leite"},
            {"quant": 100, "type": "mg", "prod": "merda"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd"
        },
        {
          "prods": [
            {"quant": 200, "type": "mg", "prod": "leite"},
            {"quant": 100, "type": "mg", "prod": "merda"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd"
        },
        {
          "prods": [
            {"quant": 500, "type": "mg", "prod": "manteiga"},
            {"quant": 200, "type": "mg", "prod": "merda"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd"
        },
        {
          "prods": [
            {"quant": 800, "type": "mg", "prod": "leadsdite"},
            {"quant": 700, "type": "mg", "prod": "cxa"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd"
        },
      ]
    };
    return receita;
  }

  @override
  void initState() {
    receita = getLista2(widget.id);
    super.initState();
  }

  void addIngredients() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Guardar receita"),
          content: new Text("Deseja guardar a receita?"),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
                main_key.currentState.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                print("Gaurdar receita");
                Navigator.of(context).pop();
                main_key.currentState.pop(context);
                main_key.currentState.pop(context);
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }

  Map<String, dynamic> receita = new Map<String, dynamic>();
  bool saved;

  ScrollController _controller = ScrollController();

  void nextPage() {
    _controller.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
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
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.red,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.green,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.yellow,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () => nextPage(),
                    child: Text("next"),
                  )
                ]))));
  }
}
