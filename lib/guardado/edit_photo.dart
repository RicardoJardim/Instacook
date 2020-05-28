import 'package:flutter/material.dart';
import '../main.dart';

class EditPhoto extends StatefulWidget {
  EditPhoto(
      {Key key, this.id, this.onClickImage, this.recipes, this.img, this.name})
      : super(key: key);
  final int id;
  final ValueChanged<String> onClickImage;
  final List recipes;
  final String img;
  final String name;
  _EditPhotoState createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  void initState() {
    urlImage = widget.img;
    super.initState();
  }

  void save() {
    widget.onClickImage(urlImage);
    main_key.currentState.pop(context);
  }

  String urlImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.name),
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
          ],
        ),
        body: SafeArea(
            top: true,
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.amber[900], width: 2),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            urlImage,
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
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GridList(
                      litems: widget.recipes,
                      onClickImage: (str) {
                        setState(() {
                          urlImage = str;
                        });
                      }),
                )
              ],
            )));
  }
}
//GRID VIEW

//ESCOLHER LIVRO DE RECEITAS
class GridList extends StatefulWidget {
  GridList({Key key, this.litems, this.onClickImage}) : super(key: key);

  final List litems;
  final ValueChanged<String> onClickImage;

  @override
  State<StatefulWidget> createState() {
    return GridItemWidget();
  }
}

class GridItemWidget extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    if (widget.litems.length != 0) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: widget.litems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.2),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  widget.onClickImage(widget.litems[index]["image"]);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.litems[index]["image"],
                    fit: BoxFit.cover,
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
                  ),
                ),
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
