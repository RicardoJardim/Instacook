import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instacook/main.dart';

class PhotoPicker extends StatefulWidget {
  PhotoPicker({Key key, this.sendPicture, this.textTitle, this.round: true})
      : super(key: key);

  final ValueChanged<File> sendPicture;
  final bool round;
  final String textTitle;
  @override
  _PhotoPickerState createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  File _selectedFile;
  bool _inProcess = false;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        width: MediaQuery.of(context).size.width - 70,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: MediaQuery.of(context).size.width - 70,
        fit: BoxFit.cover,
      );
    }
  }

  getImage(ImageSource source) async {
    var crop = CropStyle.circle;
    if (!widget.round) {
      crop = CropStyle.rectangle;
    }

    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          cropStyle: crop,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.amber[800],
            toolbarTitle: "Recorte de image",
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  void save() {
    print("SEND IMAGE");
    widget.sendPicture(_selectedFile);
    main_key.currentState.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.textTitle),
          actions: <Widget>[
            IconButton(
              enableFeedback: true,
              tooltip: "confirmar",
              icon: Icon(
                Icons.check,
                color: Colors.amber[800],
                size: 30,
              ),
              onPressed: () {
                if (_selectedFile != null) {
                  save();
                }
              },
            ),
            // overflow menu
          ],
        ),
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.round
                    ? ClipOval(
                        child: getImageWidget(),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: getImageWidget(),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        splashColor: Colors.amber,
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 35, right: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        color: Colors.amber[800],
                        onPressed: () => getImage(ImageSource.camera),
                        textColor: Colors.white,
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      FlatButton(
                        splashColor: Colors.amber,
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 35, right: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        color: Colors.amber[800],
                        onPressed: () => getImage(ImageSource.gallery),
                        textColor: Colors.white,
                        child: Text(
                          'Galeria',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            (_inProcess)
                ? Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center()
          ],
        ));
  }
}
