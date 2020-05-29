import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/Recipe.dart';
import 'package:instacook/models/User.dart';

// todas receitas 
// uma receita
// receitas por tipo
// 

class RecipeService {
  final CollectionReference recipesCollection = Firestore.instance.collection('recipe');

  // get recipes stream
  Stream<List<Recipe>> get recipes {
    return recipesCollection.snapshots().map(_recipeListFromSnapshot);
  }

  Stream<List<Recipe>> getRecipes(String param, String value) {
    print("banana");
    return recipesCollection.orderBy("date", descending: true ).snapshots().map(_recipeListFromSnapshot);
  }

  // Brew List of snapshot
  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Recipe(
          id: doc.documentID,
          name: doc.data["name"],
          type: doc.data["type"],
          props: doc.data["props"],
          likes: doc.data["likes"],
          difficulty: doc.data["difficulty"],
          description: doc.data["description"],
          imgUrl: doc.data["imgUrl"],
          privacy: doc.data["privacy"],
          prods: doc.data["prods"],
          steps: doc.data["steps"],
          userId: doc.data["userId"],
          date: doc.data["date"]
        );
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
