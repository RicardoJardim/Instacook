import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/User.dart';

class userService{

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

  Future<User> getUserId(String id) async{
    var result = await connection.collection('user').document(id).get();
    var data = result.data;
    return User(
      email: data["email"],
      username: data["username"],
      follow: data["follow"],
      followers: data["followers"],
      imgUrl: data["imgUrl"],
      recipesBook: data["recipesBook"],
      uid: data["uId"],
      proUser: data["pro"],
    );
  }

  Future insertUser(String uId, String email, String username)async{
     var result = await connection.collection('user').add(
       {
        "uid": uId,
        "email": email,
        "username": username,
        "imgUrl": "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
        "follow": [],
        "followers": [],
        "proUser": false,
        "recipesBook": []
       }
     );
  }

  List<DocumentSnapshot> documentList;  
  Future fetchFirstList() async {
    /* try { */
      documentList = (await Firestore.instance
              .collection("user")
              .limit(3)
              .getDocuments())
          .documents;
      for (var item in documentList) {
        print(item["username"]);
      }
      /* movieController.sink.add(documentList);
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      movieController.sink.addError(e); */
    }

}