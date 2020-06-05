import 'package:flutter/material.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/shopService.dart';

class MainCompras extends StatefulWidget {
  MainCompras({
    Key key,
  }) : super(key: key);

  _MainCompraslState createState() => _MainCompraslState();
}

class _MainCompraslState extends State<MainCompras> {
  final _auth = AuthService();
  final _shopService = ShopService();

  Future<List> getShoppingList() async {
    String _id = await _auth.getCurrentUser();
    var litems = await _shopService.getMyShops(_id);
    if (litems == null) {
      litems = [];
    }
    return litems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getShoppingList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                    top: true,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 80, left: 5),
                                      child: Text(
                                        "Lista de Compras",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )),
                                ListRecepie(
                                  elements: snapshot.data,
                                  shopKey: _shopService,
                                )
                              ],
                            ))));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class ListRecepie extends StatefulWidget {
  ListRecepie({Key key, this.elements, this.shopKey}) : super(key: key);

  List elements;
  final ShopService shopKey;

  @override
  _ListRecepieState createState() => _ListRecepieState();
}

class _ListRecepieState extends State<ListRecepie> {
  void deleteSingleList(String id) async {
    if (await widget.shopKey.deleteMyShopItem(id)) {
      widget.elements.removeWhere((item) => item["id"] == id);
      setState(() {
        widget.elements = widget.elements;
      });
    }
  }

  void updateSingleList(String id, List list) async {
    widget.shopKey.updateMyShop(id, list);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.elements.length != 0) {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.elements.length,
        itemBuilder: (context, index) {
          return _checkBoxList(
              id: widget.elements[index]["id"],
              title: widget.elements[index]["name"],
              subtitle: widget.elements[index]["props"].toString(),
              elements: widget.elements[index]["prods"],
              update: (id, list) {
                updateSingleList(id, list);
              },
              erase: (id) {
                deleteSingleList(id);
              });
        },
      );
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento uma lista de compras",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }

  Widget _checkBoxList(
      {String id,
      String title,
      String subtitle,
      List elements,
      Function erase,
      Function update}) {
    var ele = elements;
    return Column(children: [
      _divider(),
      ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                splashColor: Colors.amber[800],
                onTap: () {
                  erase(id);
                },
                child: Icon(
                  Icons.restore_from_trash,
                  color: Colors.grey[800],
                  size: 32,
                ),
              )
            ],
          ),
          subtitle: Text(subtitle + " porções")),
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return MyCheckBox(
              id: index,
              quantity: elements[index]["quant"].toString(),
              product: elements[index]["prod"].toString(),
              done: elements[index]["done"],
              callback: (ids, value) {
                ele[ids]["done"] = value;
                update(id, ele);
              });
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
  MyCheckBox(
      {Key key, this.quantity, this.id, this.product, this.done, this.callback})
      : super(key: key);

  final String quantity;
  final String product;
  final int id;
  final Function callback;
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
          widget.callback(widget.id, newValue);
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
