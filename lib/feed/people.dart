import 'package:flutter/material.dart';
import 'package:instacook/receitas/see_recipe.dart';
import 'package:instacook/services/auth.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/userService.dart';

import '../main.dart';

class People extends StatefulWidget {
  People({
    Key key,
    this.onPop,
    this.id,
  }) : super(key: key);

  final ValueChanged<BuildContext> onPop;
  final String id;
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  final _userService = UserService();
  final _auth = AuthService();
  final _recipeService = RecipeService();

  Future<Map> getUser() async {
    uId = await _userService.getMyID(await _auth.getCurrentUser());
    Map _map = {
      "user": await _userService.getUserById(widget.id),
      "recipes": await _recipeService.getRecipesByUserId(widget.id)
    };

    for (var i = 0; i < _map["user"].followers.length; i++) {
      if (_map["user"].followers[i] == uId) {
        subcribed = true;
      }
    }
    followers = _map["user"].followers.length;
    return _map;
  }

  bool subcribed = false;
  int followers = 0;
  String uId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
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
                    onPressed: () => widget.onPop(context),
                  ),
                ),
                body: SafeArea(
                    top: true,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  Container(
                                      height: 120,
                                      width: 120,
                                      child: Stack(children: [
                                        ClipOval(
                                          child: Image.network(
                                            snapshot.data["user"].imgUrl,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              if (progress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
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
                                        snapshot.data["user"].proUser
                                            ? Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Icon(
                                                  Icons.brightness_5,
                                                  color: Colors.blue,
                                                  size: 36,
                                                ))
                                            : Text("")
                                      ])),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      snapshot.data["user"].username,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: _submitButton(snapshot
                                        .data["user"].follow.length
                                        .toString()),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: GridList(
                                litems: snapshot.data["recipes"],
                              ),
                            )
                          ],
                        ))));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _submitButton(String follow) {
    return Column(
      children: <Widget>[
        Text(followers.toString() + " seguidores - " + follow + " a seguir"),
        Padding(
            padding: const EdgeInsets.only(top: 4),
            child: RaisedButton(
              elevation: 2,
              splashColor: !subcribed ? Colors.amber : Colors.amber[800],
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 60, right: 60),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.amber[800]),
                borderRadius: BorderRadius.circular(100),
              ),
              color: !subcribed ? Colors.amber[800] : Colors.white,
              onPressed: () {
                if (!subcribed) {
                  _userService.followUser(widget.id, uId);
                  setState(() {
                    subcribed = true;
                    followers++;
                  });
                } else {
                  _userService.unfollowUser(widget.id, uId);
                  setState(() {
                    subcribed = false;
                    followers--;
                  });
                }
              },
              child: Text(
                !subcribed ? 'Seguir' : 'Não Seguir',
                style: TextStyle(
                    fontSize: 16,
                    color: !subcribed ? Colors.white : Colors.amber[800],
                    fontWeight: FontWeight.w400),
              ),
            ))
      ],
    );
  }
}
//GRID VIEW

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({
    Key key,
    this.litems,
  }) : super(key: key);

  final List litems;
  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  //double itemHeight = 8.0;
  void seeRecipe(String id) {
    main_key.currentState.push(MaterialPageRoute(
        builder: (context) => SeeRecipe(
              id: id,
              goProfile: false,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: widget.litems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.88),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  index % 2 != 1
                      ? SizedBox(
                          height: 0,
                        )
                      : SizedBox(
                          height: 35,
                        ),
                  Container(
                    height: 190,
                    width: 300,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          seeRecipe(widget.litems[index].id);
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.litems[index].imgUrl,
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
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 2),
                                child: Text(
                                  widget.litems[index].name,
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
                                  widget.litems[index].time +
                                      " - " +
                                      widget.litems[index].difficulty,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700]),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ])),
                  ),
                ],
              ),
            );
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
