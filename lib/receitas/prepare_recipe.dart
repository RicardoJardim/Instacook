import 'package:flutter/material.dart';

import '../main.dart';

class PrepareRecipe extends StatefulWidget {
  PrepareRecipe({Key key, this.id, this.saved}) : super(key: key);

  final int id;
  final bool saved;
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
            {"quant": 200, "type": "mg", "prod": "leite"},
            {"quant": 100, "type": "mg", "prod": "merda"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sdasd asdas d asd asd a a uysgd aksb dkjahs kjdhn akjsdh kjash dkjahwsjkdh akjsdh ksjha kjdah kdjsah kjash ",
          "image":
              "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg"
        },
        {
          "prods": [
            {"quant": 200, "type": "mg", "prod": "leite"},
            {"quant": 100, "type": "mg", "prod": "merda"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd as dasd ",
          "image": " ",
        },
        {
          "prods": [
            {"quant": 500, "type": "mg", "prod": "manteiga"},
            {"quant": 200, "type": "mg", "prod": "merda"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd as dasdasd as dasdas d",
          "image":
              "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg"
        },
        {
          "prods": [
            {"quant": 800, "type": "mg", "prod": "leadsdite"},
            {"quant": 700, "type": "mg", "prod": "cxa"},
          ],
          "description":
              " Aihhdiuhasidh diahsdih iudh asidh iusuhd iash diha sda sd asda sda  s asd",
          "image": " ",
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

  void addGuardar() {
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
  int index = 0;
  ScrollController _controller = ScrollController();

  _animateToIndex(i) =>
      _controller.animateTo(MediaQuery.of(context).size.width * i,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            top: true,
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
                height: MediaQuery.of(context).size.height - 175,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: receita["steps"].length,
                    itemBuilder: (context, index) {
                      return Step(
                        index,
                        receita["steps"].length,
                        receita["steps"][index]["description"],
                        receita["steps"][index]["prods"],
                        image: receita["steps"][index]["image"],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                        splashColor: Colors.white,
                        color: Colors.black,
                        onPressed: () {
                          if (index != 0) {
                            index--;
                            _animateToIndex(index);
                          }
                        },
                        child: Center(
                            child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 40,
                        )),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(15),
                        shape: CircleBorder(),
                        color: Colors.black,
                        splashColor: Colors.white,
                        onPressed: () {
                          if (index != (receita["steps"].length - 1)) {
                            index++;
                            _animateToIndex(index);
                          } else {
                            if (!widget.saved) {
                              addGuardar();
                            } else {
                              main_key.currentState.pop(context);
                              main_key.currentState.pop(context);
                            }
                          }
                        },
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ]),
              )
            ])));
  }
}

class Step extends StatelessWidget {
  const Step(this.id, this.max, this.description, this.products, {this.image});
  final String description;
  final int id;
  final int max;
  final String image;
  final List products;

  Widget build(BuildContext context) {
    if (image != "" && image != " ") {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Passo " + (id + 1).toString(),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        "de " + max.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              image,
                              width: MediaQuery.of(context).size.width,
                              filterQuality: FilterQuality.high,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      products.length != 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Ingredientes",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          products[index]["quant"].toString() +
                                              " " +
                                              products[index]["type"] +
                                              " " +
                                              products[index]["prod"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.left,
                                        );
                                      }),
                                ],
                              ))
                          : Text(""),
                    ],
                  ))));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Passo " + (id + 1).toString(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        "de " + max.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      products.length != 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Ingredientes",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          products[index]["quant"].toString() +
                                              " " +
                                              products[index]["type"] +
                                              " " +
                                              products[index]["prod"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.left,
                                        );
                                      }),
                                ],
                              ))
                          : Text(""),
                    ],
                  ))));
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
