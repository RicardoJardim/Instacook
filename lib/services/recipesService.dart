import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/models/User.dart';

class RecipeService {
  final Firestore connection = Firestore.instance;

  List<Recipe> recipesList;
  DocumentSnapshot _lastDocument;

  _listRecipes(List<DocumentSnapshot> list) =>
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
          date: snapshot.data["date"])));

  Future getAllUserStartPag(int objNum) async {
    List<DocumentSnapshot> recipesListQ = (await connection
            .collection("recipe")
            .orderBy('username')
            .limit(objNum)
            .getDocuments())
        .documents;
    _listRecipes(recipesListQ);
    _lastDocument = recipesListQ[recipesListQ.length - 1];
  }

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
