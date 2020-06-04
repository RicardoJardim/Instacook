import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/services/recipesService.dart';
import 'package:instacook/services/userService.dart';

class SavedService {
  final Firestore connection = Firestore.instance;
  final _userService = UserService();
  final _recipeService = RecipeService();

//LIVROS DE RECEITAS
  Future<List> getMyColletions(String id) async {
    try {
      List list;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((event) {
        if (event.documents.isNotEmpty) {
          var data = event.documents.single.data;
          list = data["recipesBook"];
        }
      }).catchError((e) => print("error fetching data: $e"));
      return list;
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeRecipeFromColletion(String id, String recipeId) async {
    try {
      var result = await connection.collection("user").document(id).get();
      List list = result.data["recipesBook"];

      for (var i = 0; i < list.length; i++) {
        if (list[0]["recipes"].contains(recipeId)) {
          list[0]["recipes"].remove(recipeId);
        }
      }

      await connection
          .collection('user')
          .document(id)
          .updateData({"recipesBook": list});

      return true;
    } catch (e) {
      return false;
    }
  }

  //LIVRO id:colletionId
  Future<Map> getMyBook(String id, int colletionId) async {
    try {
      Map list;

      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((event) {
        if (event.documents.isNotEmpty) {
          var data = event.documents.single.data;
          list = data["recipesBook"]
              .firstWhere((el) => el["id"] == colletionId, orElse: () => null);
        }
      });

      return list;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateColletionImage(
      String id, int colletionId, Map data) async {
    try {
      String _id;
      List list;

      int minus = colletionId - 1;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((event) {
        _id = event.documents.single.documentID;
        list = event.documents.single.data["recipesBook"];
      });

      if (data["delete"].length != 0) {
        for (var item in data["delete"]) {
          list[minus]["recipes"].remove(item);
          await _recipeService.removeSavedRecipe(item, _id);
        }
      }

      if (data["image"] != null) {
        list[minus]["imgUrl"] = data["image"];
      }

      list[minus]["name"] = data["name"];

      await connection
          .collection('user')
          .document(_id)
          .updateData({"recipesBook": list});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteColletion(String id, int colletionId) async {
    try {
      String _id;
      List list;

      int minus = colletionId - 1;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((event) {
        _id = event.documents.single.documentID;
        list = event.documents.single.data["recipesBook"];
      });

      list.removeAt(minus);

      await connection
          .collection('user')
          .document(_id)
          .updateData({"recipesBook": list});
      return true;
    } catch (e) {
      return false;
    }
  }

  //CRIAR LIVRO DE RECEITA
  Future<bool> addColletion(String id, String name) async {
    try {
      String _id;
      List list;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((value) {
        _id = value.documents.single.documentID;
        list = value.documents.single.data["recipesBook"];
        print(_id);
      });

      list.add({
        "id": list.length + 1,
        "name": name,
        "imgUrl":
            "https://meustc.com/wp-content/uploads/2020/01/placeholder-1.png",
        "recipes": []
      });

      await connection
          .collection('user')
          .document(_id)
          .updateData({"recipesBook": list});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToColletion(String id, String recipeId, int bookId) async {
    try {
      var result = await connection.collection('user').document(id).get();
      List list = result.data["recipesBook"];

      for (var i = 0; i < list.length; i++) {
        if (list[i]["id"] == bookId) {
          list[i]["recipes"].add(recipeId);
          await connection
              .collection('user')
              .document(id)
              .updateData({"recipesBook": list});
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

//STREAMS

  //LIVROS DE RECEITAS
  Stream<DocumentSnapshot> getBooks(String id) {
    return connection.collection('user').document(id).snapshots();
  }

  Stream<DocumentSnapshot> getSingleBook(String id) {
    return connection.collection('user').document(id).snapshots();
  }

  //Receitas
  Stream<List<Recipe>> getSavedRecipes(String id, int limit) {
    return connection
        .collection('recipe')
        .limit(limit)
        .where("saved", arrayContains: id)
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
}
