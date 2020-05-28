import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class imageService {
  final Firestore connection = Firestore.instance;

  Future<Map> uploadImageToFirebase(File image, String id) async {
    try {
      String imageLocation = 'users/image$id.jpg';

      final StorageReference storageReference =
          FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;

      Map map = await _addPathToDatabase(imageLocation);
      return map;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<Map> _addPathToDatabase(String text) async {
    try {
      final ref = FirebaseStorage().ref().child(text);
      var imageString = await ref.getDownloadURL();

      Map _map = new Map();
      _map["url"] = imageString;
      _map["location"] = text;

      return _map;
    } catch (e) {
      print(e.message);

      return null;
    }
  }
}
