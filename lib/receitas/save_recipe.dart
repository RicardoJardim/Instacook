import 'package:flutter/material.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/savedService.dart';
import 'package:instacook/services/userService.dart';
import '../main.dart';

class SaveRecipe extends StatefulWidget {
  SaveRecipe({Key key, this.recipeId, this.onSave}) : super(key: key);

  final String recipeId;
  final ValueChanged<bool> onSave;

  _SaveRecipelState createState() => _SaveRecipelState();
}

class _SaveRecipelState extends State<SaveRecipe> {
  final _auth = AuthService();
  final _savedService = SavedService();
  final _recipesService = RecipeService();
  final _userService = UserService();

  String _id;
  String iD;
  Future<List> getColletions() async {
    _id = await _auth.getCurrentUser();
    iD = await _userService.getMyID(_id);

    var litems = await _savedService.getMyColletions(_id);
    return litems;
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
            onPressed: () {
              widget.onSave(false);
              main_key.currentState.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: getColletions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: SwipeList(
                        litems: snapshot.data,
                        recipeId: widget.recipeId,
                        onSave: (bool saved, int collid) async {
                          widget.onSave(saved);
                          var check = await _savedService.addToColletion(
                              iD, widget.recipeId, collid);
                          print(check);
                          var dou = await _recipesService.addSavedRecipe(
                              widget.recipeId, iD);
                          if (dou) {
                            main_key.currentState.pop(context);
                          }

                          print("save recipe id " +
                              widget.recipeId +
                              " on collection " +
                              collid.toString());
                        }));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class SwipeList extends StatefulWidget {
  SwipeList({Key key, this.litems, this.recipeId, this.onSave})
      : super(key: key);

  final List litems;
  final String recipeId;
  final Function onSave;

  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  void save(int id) {
    widget.onSave(true, id);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.litems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: RaisedButton(
                color: Colors.amber[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(7),
                onPressed: () {
                  save(widget.litems[index]["id"]);
                },
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.amber[900], width: 2)),
                        child: ClipOval(
                          child: Image.network(
                            widget.litems[index]["imgUrl"],
                            fit: BoxFit.cover,
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
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.litems[index]["name"],
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                )),
          );
        },
      );
    } else {
      return Center(
          heightFactor: 15,
          child: Text(
            "Não tem neste momento nenhum livro de receitas",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ));
    }
  }
}
