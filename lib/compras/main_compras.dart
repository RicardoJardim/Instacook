import 'package:flutter/material.dart';

class MainCompras extends StatefulWidget {
  MainCompras({
    Key key,
  }) : super(key: key);

  _MainCompraslState createState() => _MainCompraslState();
}

/*
{
  "receitas x":[
    {
      nome:"dasd",
      props: "2",
      prods:[  
        {
          quant:"12",
          prod: "x"
        },
        {
          quant:"12",
          prod: "x"
        },
      ]
    }
  ]
}
*/

class _MainCompraslState extends State<MainCompras> {
  static List getLista2() {
    var receita = new List<Map<String, dynamic>>();

    receita = [
      {
        "id": 1,
        "nome": "Pizza de Frango",
        "props": 2,
        "prods": [
          {"quant": "250 mg", "prod": "leite", "done": true},
          {"quant": "300 mg", "prod": "merda", "done": true},
          {"quant": "300 mg", "prod": "merda", "done": false},
          {"quant": "300 mg", "prod": "merda", "done": true},
        ]
      },
      {
        "id": 2,
        "nome": "Pizza de Camarao",
        "props": 3,
        "prods": [
          {"quant": "250 mg", "prod": "leite", "done": true},
          {"quant": "300 mg", "prod": "merda", "done": true},
        ]
      },
      {
        "id": 3,
        "nome": "Pizza de Aborora",
        "props": 3,
        "prods": [
          {"quant": "250 mg", "prod": "leite", "done": false},
          {"quant": "300 mg", "prod": "merda", "done": false},
        ]
      }
    ];
    return receita;
  }

  static List<Map<String, dynamic>> receitas = getLista2();

  @override
  Widget build(BuildContext context) {
    getLista2();
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 17, right: 80, left: 7),
                          child: Text(
                            "Lista de Compras",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700),
                          ),
                        )),
                    ListRecepie(
                      elements: receitas,
                    )
                  ],
                ))));
  }
}

class ListRecepie extends StatefulWidget {
  ListRecepie({Key key, this.elements}) : super(key: key);

  List elements;
  @override
  _ListRecepieState createState() => _ListRecepieState();
}

class _ListRecepieState extends State<ListRecepie> {
  void updateList(int id) {
    widget.elements.removeWhere((item) => item["id"] == id);

    setState(() {
      widget.elements = widget.elements;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.elements.length != 0) {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.elements.length,
        itemBuilder: (context, index) {
          return CheckBoxList(
              id: widget.elements[index]["id"],
              title: widget.elements[index]["nome"],
              subtitle: widget.elements[index]["props"].toString(),
              elements: widget.elements[index]["prods"],
              erase: (id) {
                updateList(id);
              });
        },
      );
    } else {
      return Center(
          heightFactor: 25,
          child: Text(
            "Não tem neste momento uma lista de compras",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}

class CheckBoxList extends StatefulWidget {
  CheckBoxList(
      {Key key, this.id, this.title, this.subtitle, this.elements, this.erase})
      : super(key: key);

  final List elements;
  final int id;
  final String title;
  final String subtitle;
  final Function erase;

  @override
  _CheckBoxListState createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _divider(),
      ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                splashColor: Colors.amber[800],
                onTap: () {
                  widget.erase(widget.id);
                },
                child: Icon(
                  Icons.restore_from_trash,
                  color: Colors.grey[800],
                  size: 32,
                ),
              )
            ],
          ),
          subtitle: Text(widget.subtitle + " porções")),
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.elements.length,
        itemBuilder: (context, index) {
          return MyCheckBox(
              quantity: widget.elements[index]["quant"],
              product: widget.elements[index]["prod"],
              done: widget.elements[index]["done"]);
        },
      ),
    ]);
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
}

class MyCheckBox extends StatefulWidget {
  MyCheckBox({Key key, this.quantity, this.product, this.done})
      : super(key: key);

  final String quantity;
  final String product;
  bool done;

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<MyCheckBox> {
  TextDecoration decord;
  @override
  Widget build(BuildContext context) {
    if (widget.done) {
      decord = TextDecoration.lineThrough;
    } else {
      decord = TextDecoration.none;
    }
    return LabeledCheckbox(
        quantity: widget.quantity,
        product: widget.product,
        value: widget.done,
        onChanged: (bool newValue) {
          var aux = TextDecoration.none;
          if (!newValue) {
            aux = TextDecoration.none;
          } else {
            aux = TextDecoration.lineThrough;
          }
          setState(() {
            widget.done = newValue;
            decord = aux;
          });
        },
        decordText: decord);
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox(
      {this.quantity,
      this.product,
      this.value,
      this.onChanged,
      this.decordText});

  final String quantity;
  final String product;
  final bool value;
  final Function onChanged;
  final TextDecoration decordText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Transform.scale(
              scale: 1.4,
              child: Checkbox(
                activeColor: Colors.amber[800],
                value: value,
                onChanged: (bool newValue) {
                  onChanged(newValue);
                },
              )),
          Text(quantity + " - ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  decoration: decordText)),
          Text(product,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  decoration: decordText)),
        ],
      ),
    );
  }
}
