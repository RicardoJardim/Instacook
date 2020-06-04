import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/services/imageService.dart';
import 'package:instacook/services/userService.dart';

class RecipeService {
  final CollectionReference recipesCollection =
      Firestore.instance.collection('recipe');

  final Firestore connection = Firestore.instance;
  final _imageService = ImageService();
  final _userService = UserService();

  Future<bool> insertRecipe(String uId, Recipe data) async {
    try {
      String _id = await _userService.getMyID(uId);

      var result = await connection.collection('recipe').add({
        "name": data.name,
        "type": data.type,
        "props": data.props,
        "likes": [],
        "saved": [],
        "difficulty": data.difficulty,
        "description": data.description,
        "privacy": data.privacy,
        "prods": data.prods,
        "time": data.time,
        "userId": _id,
        "date": new DateTime.now()
      });

      var steps = data.steps;

      for (var i = 0; i < data.steps.length; i++) {
        if (data.steps[i]["imgUrl"] != "") {
          var _map = await _imageService.uploadImageToFirebase(
              data.steps[i]["imgUrl"], "ing", result.documentID + i.toString());
          steps[i]["imgUrl"] = _map["url"];
          steps[i]["location"] = _map["location"];
        }
      }

      var _map = await _imageService.uploadImageToFirebase(
          data.imgUrl, "images", result.documentID);

      await connection
          .collection('recipe')
          .document(result.documentID)
          .updateData({
        'steps': steps,
        'imgUrl': _map["url"],
        'location': _map["location"]
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateRecipe(String uId, Recipe data) async {
    try {
      var steps = data.steps;

      for (var i = 0; i < data.steps.length; i++) {
        if (data.steps[i]["imgUrl"] != "" && data.steps[i]["imgUrl"] is File) {
          var _map = await _imageService.uploadImageToFirebase(
              data.steps[i]["imgUrl"], "ing", data.id + i.toString());
          steps[i]["imgUrl"] = _map["url"];
          steps[i]["location"] = _map["location"];
        }
      }

      if (data.imgUrl is File) {
        print("send");
        var _map = await _imageService.updateImageToFirebase(
            data.imgUrl, "images", data.id);

        await connection
            .collection('recipe')
            .document(data.id)
            .updateData({'imgUrl': _map["url"], 'location': _map["location"]});
      }

      await connection.collection('recipe').document(data.id).updateData({
        "name": data.name,
        "type": data.type,
        "props": data.props,
        "difficulty": data.difficulty,
        "description": data.description,
        "privacy": data.privacy,
        "prods": data.prods,
        "time": data.time,
        'steps': steps,
        "date": new DateTime.now()
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Recipe> getSingleRecipe(String id) async {
    try {
      var result = await connection.collection('recipe').document(id).get();
      var data = result.data;
      return Recipe(
          id: result.documentID,
          name: data["name"],
          type: data["type"],
          props: data["props"],
          likes: data["likes"],
          saved: data["saved"],
          difficulty: data["difficulty"],
          description: data["description"],
          imgUrl: data["imgUrl"],
          time: data["time"],
          privacy: data["privacy"],
          prods: data["prods"],
          userId: data["userId"],
          date: data["date"]);
    } catch (e) {
      return null;
    }
  }

  Future<Recipe> getSingleRecipeSmall(String id) async {
    try {
      var result = await connection.collection('recipe').document(id).get();
      var data = result.data;
      return Recipe(
        id: result.documentID,
        name: data["name"],
        difficulty: data["difficulty"],
        imgUrl: data["imgUrl"],
        time: data["time"],
      );
    } catch (e) {
      return null;
    }
  }

  Future<Recipe> getSingleSteps(String id) async {
    try {
      var result = await connection.collection('recipe').document(id).get();
      var data = result.data;

      return Recipe(id: result.documentID, steps: data["steps"]);
    } catch (e) {
      return null;
    }
  }

  Future<bool> addLikeRecipe(String id, String uId) async {
    try {
      await connection.collection('recipe').document(id).updateData({
        'likes': FieldValue.arrayUnion([uId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeLikeRecipe(String id, String uId) async {
    try {
      await connection.collection('recipe').document(id).updateData({
        'likes': FieldValue.arrayRemove([uId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addSavedRecipe(String id, String uId) async {
    try {
      await connection.collection('recipe').document(id).updateData({
        'saved': FieldValue.arrayUnion([uId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeSavedRecipe(String id, String uId) async {
    try {
      await connection.collection('recipe').document(id).updateData({
        'saved': FieldValue.arrayRemove([uId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Recipe>> getRecipesByUserId(String id) async {
    try {
      List<Recipe> recipes = List<Recipe>();

      await connection
          .collection('recipe')
          .where("userId", isEqualTo: id)
          .where("privacy", isEqualTo: false)
          .orderBy("date", descending: true)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          recipes.add(new Recipe(
              name: f.data["name"],
              id: f.documentID,
              imgUrl: f.data["imgUrl"],
              time: f.data["time"],
              difficulty: f.data["difficulty"]));
        });
      });

      return recipes;
    } catch (e) {
      return null;
    }
  }

  // STREAMS
  Stream<List<Recipe>> get recipes {
    return recipesCollection
        .orderBy("date", descending: true)
        .snapshots()
        .map(_recipeListFromSnapshot);
  }

  Stream<List<Recipe>> getRecipes(String param, String value) {
    return recipesCollection
        .where(param, isEqualTo: value)
        .where("privacy", isEqualTo: false)
        .orderBy("date", descending: true)
        .snapshots()
        .map(_recipeListFromSnapshot);
  }

  Stream<List<Recipe>> getMyRecipes(String param, String value) {
    return recipesCollection
        .where(param, isEqualTo: value)
        .orderBy("date", descending: true)
        .snapshots()
        .map(_recipeListFromSnapshot);
  }

  // Recipe List of snapshot
  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Recipe(
          id: doc.documentID,
          name: doc.data["name"],
          type: doc.data["type"],
          props: doc.data["props"],
          likes: doc.data["likes"],
          saved: doc.data["saved"],
          difficulty: doc.data["difficulty"],
          description: doc.data["description"],
          imgUrl: doc.data["imgUrl"],
          privacy: doc.data["privacy"],
          prods: doc.data["prods"],
          steps: doc.data["steps"],
          userId: doc.data["userId"],
          time: doc.data["time"],
          date: doc.data["date"]);
    }).toList();
  }

  //FEED

  // Stream  List<Map> user + recipe
  Stream<List<Map>> getRecipesAndUser(/* String param, String value */) {
    return recipesCollection
        //.where(param, isEqualTo: value)
        .orderBy("date", descending: true)
        .snapshots()
        .map(_recipeAndUserListFromSnapshot);
  }

  // Recipe List of snapshot
  List<Map> _recipeAndUserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      connection
          .collection('user')
          .document(doc.data["userId"])
          .snapshots()
          .listen((user) {
        Map _map = {
          "recipe": Recipe(
              id: doc.documentID,
              name: doc.data["name"],
              type: doc.data["type"],
              props: doc.data["props"],
              likes: doc.data["likes"],
              saved: doc.data["saved"],
              difficulty: doc.data["difficulty"],
              description: doc.data["description"],
              imgUrl: doc.data["imgUrl"],
              privacy: doc.data["privacy"],
              prods: doc.data["prods"],
              steps: doc.data["steps"],
              userId: doc.data["userId"],
              time: doc.data["time"],
              date: doc.data["date"]),
          "user": user.data
        };
        print(_map);
        return _map;
      });
    }).toList();
  }

  /*  _listRecipes(List<DocumentSnapshot> list) =>
      list.map((snapshot) => recipesList.add(Recipe(
          id: snapshot.documentID,
          name: snapshot.data["name"],
          type: snapshot.data["type"],
          props: snapshot.data["props"],
          likes: snapshot.data["likes"],
          difficulty: snapshot.data["difficulty"],
          description: snapshot.data["description"],
          imgUrl: snapshot.data["imgUrl"],
          privacy: snapshot.data["privacy"],
          prods: snapshot.data["prods"],
          steps: snapshot.data["steps"],
          userId: snapshot.data["userId"],
          date: snapshot.data["date"]))); */

  /* Future getAllUserStartPag(int objNum) async {
    List<DocumentSnapshot> recipesListQ = (await connection
            .orderBy('username')
            .limit(objNum)
            .getDocuments())
        .documents;
    _listRecipes(recipesListQ);
    _lastDocument = recipesListQ[recipesListQ.length - 1];
  } */

  /*  Future getMoreUsers( int objNum)async {
    List<DocumentSnapshot> newList = (await connection
    .collection('user')
    .orderBy('username')
    .startAfterDocument(_lastDocument)
    .limit(objNum)
    .getDocuments())
    .documents;

    userList += newList;

    for (var item in userList) {
        print(item["username"]);
      }

  } */

}
