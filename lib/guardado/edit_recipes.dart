import 'package:flutter/material.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/services/recipesService.dart';
import '../main.dart';

class EditRecipes extends StatefulWidget {
  EditRecipes({Key key, this.id, this.recipes, this.callback})
      : super(key: key);
  final int id;
  final List recipes;
  final ValueChanged<List> callback;
  _EditRecipesState createState() => _EditRecipesState();
}

class _EditRecipesState extends State<EditRecipes> {
  void save() {
    if (removeRecipes.length != 0) {
      removeRecipes.forEach((el) {
        print("remove recipe with id " + el.toString());
      });
      print(removeRecipes);
      widget.callback(removeRecipes);
    }

    main_key.currentState.pop(context);
  }

  List removeRecipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Remover receitas"),
          actions: <Widget>[
            IconButton(
              enableFeedback: true,
              tooltip: "confirmar",
              icon: Icon(
                Icons.check,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                save();
              },
            ),
            // overflow menu
          ],
        ),
        body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GridList(
                  litems: widget.recipes,
                  onClickRecipe: (id) {
                    var aux = removeRecipes;
                    if (removeRecipes.contains(id)) {
                      aux.remove(id);
                    } else {
                      aux.add(id);
                    }
                    setState(() {
                      removeRecipes = aux;
                    });
                    aux = null;
                  }),
            )));
  }
}
//GRID VIEW

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({Key key, this.litems, this.onClickRecipe}) : super(key: key);

  final List litems;
  final ValueChanged<String> onClickRecipe;

  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  final _recipeService = RecipeService();
  Future<Recipe> getRecipe(String id) async {
    var reci = await _recipeService.getSingleRecipeSmall(id);
    return reci;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: widget.litems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.92),
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: getRecipe(widget.litems[index]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        height: 190,
                        width: 300,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  height: 140,
                                  width: 300,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          snapshot.data.imgUrl,
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
                                        ),
                                      ),
                                      Positioned(
                                          right: -2,
                                          bottom: -2,
                                          child: Container(
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            child: CheckBoxWidget(
                                              callback: () =>
                                                  widget.onClickRecipe(
                                                      snapshot.data.id),
                                            ),
                                          ))
                                    ],
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  snapshot.data.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  snapshot.data.time +
                                      " - " +
                                      snapshot.data.difficulty,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700]),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ]),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          });
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento receitas criadas",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}

class CheckBoxWidget extends StatefulWidget {
  CheckBoxWidget({Key key, this.callback}) : super(key: key);

  final Function callback;
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBoxWidget> {
  void onChanged(bool newValue) {
    setState(() {
      value = newValue;
    });
    widget.callback();
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.6,
        child: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.amber[800],
          value: value,
          onChanged: (bool newValue) {
            onChanged(newValue);
          },
        ));
  }
}
