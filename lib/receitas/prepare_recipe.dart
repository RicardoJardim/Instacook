import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/receitas/save_recipe.dart';
import 'package:instacook/services/recipesService.dart';

import '../main.dart';

class PrepareRecipe extends StatefulWidget {
  PrepareRecipe({Key key, this.id, this.saved}) : super(key: key);

  final String id;
  final bool saved;
  _PrepareRecipelState createState() => _PrepareRecipelState();
}

class _PrepareRecipelState extends State<PrepareRecipe> {
  final _recipeService = RecipeService();
  var uId;
  Future<Recipe> getSteps() async {
    //widget.id
    return await _recipeService.getSingleSteps("pqbdR1eCNIm9hN3fzvrU");
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
                main_key.currentState.push(MaterialPageRoute(
                    builder: (context) => SaveRecipe(
                          recipeId: widget.id,
                          onSave: (saved) {
                            if (saved) {
                              print("GUARDAR DOS GUARDADOS " + widget.id);
                            }
                          },
                        )));
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }

  bool saved;
  int index = 0;
  ScrollController _controller = ScrollController();

  _animateToIndex(i) =>
      _controller.animateTo(MediaQuery.of(context).size.width * i,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSteps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                            itemCount: snapshot.data.steps.length,
                            itemBuilder: (context, index) {
                              return Step(
                                index,
                                snapshot.data.steps.length,
                                snapshot.data.steps[index]["description"],
                                snapshot.data.steps[index]["prods"],
                                image: snapshot.data.steps[index]["imgUrl"],
                              );
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
                                  if (index !=
                                      (snapshot.data.steps.length - 1)) {
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes
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
