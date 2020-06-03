import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/services/userService.dart';

class SavedService {
  final Firestore connection = Firestore.instance;
  final _userService = UserService();

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

  //RECEITAS PELO MAIS RECENTE LIMIT 10
  Future<List> getMyNews(String id) async {
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
          list[minus]["recipes"].remove(item.toString());
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

  //RECEITAS DO LIVRO id:colletionId
  Future<List> getMyRecipesFromColletion(String id, int colletionId) async {
    try {
      List list;

      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((event) {
        if (event.documents.isNotEmpty) {
          var data = event.documents.single.data;
          var under = data["recipesBook"]
              .firstWhere((el) => el["id"] == colletionId, orElse: () => null);
          list = under["recipes"];
        }
      });
      return list;
    } catch (e) {
      return null;
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
}
