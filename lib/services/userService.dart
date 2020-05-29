import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/User.dart';
import 'package:instacook/services/imageService.dart';

class UserService {
  final Firestore connection = Firestore.instance;

  final _imageService = ImageService();

  Future<String> getMyID(String id) async {
    try {
      String _id;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((value) {
        _id = value.documents.single.documentID;
      });
      return _id;
    } catch (e) {
      return null;
    }
  }

  //MyUSER
  Future<User> getMyUser(String id) async {
    try {
      User user;
      await connection
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

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateMyUserData(String id, Map data) async {
    try {
      String _id;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((value) {
        _id = value.documents.single.documentID;
        print(_id);
      });

      await connection
          .collection('user')
          .document(_id)
          .updateData({"username": data["username"], "email": data["email"]});

      if (data["image"] != null) {
        var _map = await _imageService.uploadImageToFirebase(
            data["image"], "users", _id);

        if (_map != null) {
          await connection.collection('user').document(_id).updateData(
              {'imgUrl': _map["url"], 'location': _map["location"]});
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMyUserData(String id) async {
    try {
      String _id;
      await connection
          .collection('user')
          .where("uid", isEqualTo: id)
          .getDocuments()
          .then((value) {
        _id = value.documents.single.documentID;
        print(_id);
      });

      await connection.collection('user').document(_id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  //OTHERS
  Future<List> getUsers() async {
    try {
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
    } catch (e) {
      return null;
    }
  }

  Future<User> getUserId(String id) async {
    try {
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
    } catch (e) {
      return null;
    }
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
        "recipesBook": [
          {
            "id": 1,
            "name": "Geral",
            "imgUrl":
                "https://meustc.com/wp-content/uploads/2020/01/placeholder-1.png",
            "recipes": []
          }
        ],
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  List<DocumentSnapshot> userList;
  DocumentSnapshot _lastDocument;

  Future getAllUserStartPag(int objNum) async {
    userList = (await connection
            .collection("user")
            .orderBy('username')
            .limit(objNum)
            .getDocuments())
        .documents;
    for (var item in userList) {
      print(item["username"]);
    }
    _lastDocument = userList[userList.length - 1];
  }

  Future getMoreUsers(int objNum) async {
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
  }
}
