import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/models/User.dart';
import 'package:instacook/services/imageService.dart';

class UserService {
  final Firestore connection = Firestore.instance;

  final _imageService = ImageService();

  //MyDocumentId
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
            id: event.documents.single.documentID,
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

  //MyUpdate
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

  //MyDelete
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

  //UserFromRecipe
  Future<User> getUserRecipe(String id) async {
    try {
      var result = await connection.collection('user').document(id).get();
      var data = result.data;
      return User(
        id: result.documentID,
        email: "",
        username: data["username"],
        follow: [],
        followers: [],
        imgUrl: data["imgUrl"],
        recipesBook: [],
        uid: "",
        proUser: data["proUser"],
      );
    } catch (e) {
      return null;
    }
  }

  //GetUserById
  Future<User> getUserById(String id) async {
    try {
      var result = await connection.collection('user').document(id).get();
      var data = result.data;
      return User(
        id: result.documentID,
        username: data["username"],
        follow: data["follow"],
        followers: data["followers"],
        imgUrl: data["imgUrl"],
        proUser: data["proUser"],
      );
    } catch (e) {
      return null;
    }
  }

  //MyCreate
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

  //FOLLOW
  Future<bool> followUser(String id, String uId) async {
    try {
      await connection.collection('user').document(id).updateData({
        'followers': FieldValue.arrayUnion([uId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  //UNFOLLOW
  Future<bool> unfollowUser(String id, String uId) async {
    try {
      await connection.collection('user').document(id).updateData({
        'followers': FieldValue.arrayRemove([uId])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<User>> getAllUsersStream(String param, String value) {
    return connection
        .collection('user')
        .where(param, isEqualTo: value)
        .orderBy("followers", descending: true)
        .orderBy("name")
        .snapshots()
        .map(_userListFromSnapshot);
  }

  // User List of snapshot
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
          email: doc.data["email"],
          id: doc.documentID,
          uid: doc.data["uid"],
          username: doc.data["username"],
          imgUrl: doc.data["imgUrl"],
          follow: doc.data["follow"],
          followers: doc.data["followers"],
          proUser: doc.data["proUser"],
          recipesBook: doc.data["recipesBook"]);
    }).toList();
  }
}
