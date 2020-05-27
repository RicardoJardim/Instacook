import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/User.dart';

class recipeService{

  final Firestore connection = Firestore.instance;

  //connection.collection('coolName').snapshot

  Future getUsers() async{
    List <User> users = List<User>();
    dynamic result = await connection.collection('user')
    .snapshots()
    .listen((data) =>
        data.documents.forEach((user) =>{
          users.add(User(username: user["username"]))
        }));
    
    for (var user in users) {
      print(user.username);
    }
  }

}