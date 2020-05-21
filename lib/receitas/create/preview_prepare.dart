import 'dart:io';
import 'package:flutter/material.dart';
import '../../main.dart';

class PreviewPrepare extends StatefulWidget {
  PreviewPrepare({Key key, this.receita}) : super(key: key);

  final Map receita;

  _PreviewPreparelState createState() => _PreviewPreparelState();
}

class _PreviewPreparelState extends State<PreviewPrepare> {
  int index = 0;
  ScrollController _controller = ScrollController();

  _animateToIndex(i) =>
      _controller.animateTo(MediaQuery.of(context).size.width * i,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  void saveRecipe() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Finalizar receita"),
          content: new Text("Deseja guardar a receita?"),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlatButton(
                child: new Text(
                  "Eliminar",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  main_key.currentState.pop(context);
                  main_key.currentState.pop(context);
                  main_key.currentState.pop(context);
                },
                textColor: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlatButton(
                child: new Text(
                  "Guardar",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (widget.receita["id"] == null) {
                    print("guardar " + widget.receita.toString());
                  } else {
                    print("editar " + widget.receita.toString());
                  }
                  main_key.currentState.pop(context);
                  main_key.currentState.pop(context);
                  main_key.currentState.pop(context);
                },
                textColor: Colors.green,
              ),
            ),
          ],
          elevation: 24,
        );
      },
    );
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
            onPressed: () => main_key.currentState.pop(context),
          ),
          actions: <Widget>[
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                enableFeedback: true,
                tooltip: "confirmar",
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 34,
                ),
                onPressed: () {
                  print("concluir");
                  saveRecipe();
                })
          ],
        ),
        body: SafeArea(
            top: true,
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height - 170,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.receita["steps"].length,
                    itemBuilder: (context, index) {
                      if (widget.receita["steps"][index]["image"] is String) {
                        return Step(
                          index,
                          widget.receita["steps"].length,
                          widget.receita["steps"][index]["description"],
                          widget.receita["steps"][index]["prods"],
                          null,
                          widget.receita["steps"][index]["image"],
                        );
                      } else {
                        return Step(
                          index,
                          widget.receita["steps"].length,
                          widget.receita["steps"][index]["description"],
                          widget.receita["steps"][index]["prods"],
                          widget.receita["steps"][index]["image"],
                          "",
                        );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          if (index != (widget.receita["steps"].length - 1)) {
                            index++;
                            _animateToIndex(index);
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
  const Step(this.id, this.max, this.description, this.products, this.image,
      this.image2);
  final String description;
  final int id;
  final int max;
  final List products;
  final File image;
  final String image2;

  Widget build(BuildContext context) {
    print(image);
    print(image2);

    if (image == null && (image2 == " " || image2 == "")) {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Passo " + (id + 1).toString(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "de " + max.toString(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.fade,
                        ),
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
                                      primary: false,
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Passo " + (id + 1).toString(),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "de " + max.toString(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: 310,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(8, 8), //(x,y)
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: image != null
                                    ? Image.file(
                                        image,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      )
                                    : Image.network(
                                        image2,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                        loadingBuilder:
                                            (context, child, progress) {
                                          if (progress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: progress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? progress
                                                          .cumulativeBytesLoaded /
                                                      progress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                        },
                                      ))),
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
