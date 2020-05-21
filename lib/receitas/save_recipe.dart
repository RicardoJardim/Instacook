import 'package:flutter/material.dart';
import '../main.dart';

class SaveRecipe extends StatefulWidget {
  SaveRecipe({Key key, this.recipeId, this.onSave}) : super(key: key);

  final int recipeId;
  final ValueChanged<bool> onSave;

  _SaveRecipelState createState() => _SaveRecipelState();
}

class _SaveRecipelState extends State<SaveRecipe> {
  static List onSomeEvent() {
    List<Map> litems = [
      {
        "id": 5,
        "name": "Geral",
        "image":
            "https://restaurants.mu/blog-admin/wp-content/uploads/2019/05/1.jpg"
      },
      {
        "id": 1,
        "name": "Pregos",
        "image":
            "https://nit.pt/wp-content/uploads/2018/07/95915588dd8f97db9b5bedd24ea068a5-754x394.jpg"
      },
      {
        "id": 2,
        "name": "Peixes",
        "image":
            "https://s2.glbimg.com/sGfe5ndqXQ_LPvFNH24x0akv0NE=/300x375/e.glbimg.com/og/ed/f/original/2014/02/03/cc22api_184.jpg"
      },
      {
        "id": 3,
        "name": "Pizzas",
        "image": "https://www.delonghi.com/Global/recipes/multifry/3.jpg"
      },
      {
        "id": 4,
        "name": "Carnes",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTpgNdlNQQ2rGCZhwTe16Dc3axujG2UtE_4Q8R77Y0LSrG58Zjf&usqp=CAU"
      },
    ];
    return litems;
  }

  static List<Map> litems = onSomeEvent();
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
        body: Center(
            child: SwipeList(
                litems: litems,
                recipeId: widget.recipeId,
                onSave: (saved) => widget.onSave(saved))));
  }
}

class SwipeList extends StatefulWidget {
  SwipeList({Key key, this.litems, this.recipeId, this.onSave})
      : super(key: key);

  final List litems;
  final int recipeId;
  final ValueChanged<bool> onSave;

  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  void save(int id) {
    main_key.currentState.pop(context);
    print("save recipe id " +
        widget.recipeId.toString() +
        " on collection " +
        id.toString());
    widget.onSave(true);
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
                            widget.litems[index]["image"],
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
