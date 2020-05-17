import 'dart:io';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../photo_picker.dart';

class AddStep extends StatefulWidget {
  AddStep({Key key, this.callback, this.ingr}) : super(key: key);

  final ValueChanged<Map> callback;
  final List ingr;
  _AddSteplState createState() => _AddSteplState();
}

class _AddSteplState extends State<AddStep> {
  final description = TextEditingController();
  File _selectedFile;

  List list = new List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Passo",
            style: TextStyle(fontSize: 24),
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 34,
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
                color: Colors.amber[800],
                size: 34,
              ),
              onPressed: () {
                if (description.text != "") {
                  widget.callback({
                    "description": description.text,
                    "prods": list,
                    "image": _selectedFile == null ? "" : _selectedFile
                  });
                  main_key.currentState.pop(context);
                }
              },
            ),
          ],
        ),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                      child: Text("Foto deste passo",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width - 140,
                            child: InkWell(
                              onTap: () {
                                main_key.currentState.push(MaterialPageRoute(
                                    builder: (context) => PhotoPicker(
                                          textTitle: "Foto do passo",
                                          round: false,
                                          sendPicture: (image) {
                                            setState(() {
                                              _selectedFile = image;
                                            });
                                          },
                                        )));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: getImageWidget(),
                              ),
                            )),
                      ),
                    ),
                    _entryField("Descrição", "Descriva o passo", description),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: ButtonTheme(
                            minWidth: 200.0,
                            child: FlatButton(
                                onPressed: () {
                                  _showMultiSelect(context);
                                },
                                autofocus: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                                splashColor: Colors.amber[800],
                                color: Colors.amber[800],
                                child: Text(
                                  "Escolher Ingredientes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ))),
                      ),
                    ),
                  ],
                ))));
  }

  void _showMultiSelect(BuildContext context) {
    final items = <MultiSelectDialogItem<Map>>[];
    widget.ingr.forEach((element) {
      print(element);
      items.add(
        MultiSelectDialogItem({
          "quant": element["quant"],
          "prod": element["prod"],
          "type": element["type"]
        }, element["quant"] + " " + element["prod"] + " " + element["type"]),
      );
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          callback: (lists) {
            list = lists;
          },
        );
      },
    );
  }

  Widget _entryField(
    String title,
    String example,
    TextEditingController _controller,
  ) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          autofocus: false,
          focusNode: FocusNode(canRequestFocus: false),
          controller: _controller,
          style: TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            labelText: title,
            helperText: "Ex: " + example,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber[800], width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber[800], width: 2),
            ),
          ),
        ));
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        fit: BoxFit.cover,
      );
    }
  }
}

class MultiSelectDialogItem<Map> {
  const MultiSelectDialogItem(this.value, this.label);

  final Map value;
  final String label;
}

class MultiSelectDialog<Map> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.callback}) : super(key: key);

  final List<MultiSelectDialogItem<Map>> items;
  final ValueChanged<List> callback;
  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<Map>();
}

class _MultiSelectDialogState<Map> extends State<MultiSelectDialog<Map>> {
  final _selectedValues = List();

  void initState() {
    super.initState();
  }

  void _onItemCheckedChange(Map itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    widget.callback(_selectedValues);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ingredientes'),
      contentPadding: EdgeInsets.only(top: 18.0),
      content: SingleChildScrollView(
        child: widget.items.length != 0
            ? ListTileTheme(
                contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
                child:
                    ListBody(children: widget.items.map(_buildItem).toList()),
              )
            : Center(child: Text("Não inserio ingredientes na receita")),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<Map> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
