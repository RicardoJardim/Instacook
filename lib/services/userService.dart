import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/User.dart';

class userService {
  final Firestore connection = Firestore.instance;

  Future<User> getMyUser(String id) async {
    User user;
    await Firestore.instance
        .collection('user')
        .where("uid", isEqualTo: id)
        .getDocuments()
        .then((event) {
      if (event.documents.isNotEmpty) {
        var data = event.documents.single.data;
        user = User(
          email: data["email"],
          username: data["username"],
          follow: data["follow"],
          followers: data["followers"],
          imgUrl: data["imgUrl"],
          recipesBook: data["recipesBook"],
          uid: data["uId"],
          proUser: data["proUser"],
        );
      }
    }).catchError((e) => print("error fetching data: $e"));

    if (user != null) {
      print(user.proUser);
      return user;
    } else {
      return null;
    }
  }

  Future<List> getUsers() async {
    List<User> users = List<User>();

    connection
        .collection('user')
        .snapshots()
        .listen((data) => data.documents.forEach((user) => {
              users.add(User(
                username: user["username"],
                imgUrl: user["imgUrl"],
                uid: user["uId"],
                proUser: user["pro"],
              ))
            }));

    for (var user in users) {
      print(user.username);
    }
    return users;
  }

  Future<User> getUserId(String id) async {
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

  Future<bool> insertUser(String uId, String email, String username) async {
    try {
      await connection.collection('user').add({
        "uid": uId,
        "email": email,
        "username": username,
        "imgUrl":
            "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
        "follow": [],
        "followers": [],
        "proUser": false,
        "recipesBook": []
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
