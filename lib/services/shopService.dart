import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instacook/services/userService.dart';

class ShopService {
  final Firestore connection = Firestore.instance;
  final _userService = UserService();
  Future<bool> insertShop(String uId, Map data) async {
    try {
      String _id = await _userService.getMyID(uId);

      for (var i = 0; i < data["prods"].length; i++) {
        data["prods"][i]["done"] = false;
      }
      var result = await connection.collection('shop').add({
        "name": data["name"],
        "props": data["props"],
        "prods": data["prods"],
        "userId": _id,
        "date": new DateTime.now()
      });
      await connection
          .collection('shop')
          .document(result.documentID)
          .updateData({"id": result.documentID});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateMyShop(String id, List data) async {
    try {
      await connection
          .collection('shop')
          .document(id)
          .updateData({"prods": data});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMyShopItem(String id) async {
    try {
      await connection.collection('shop').document(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List> getMyShops(String id) async {
    try {
      String _id = await _userService.getMyID(id);
      List<Map> list = new List<Map>();
      await connection
          .collection('shop')
          .where("userId", isEqualTo: _id)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          list.add({
            "name": f.data["name"],
            "prods": f.data["prods"],
            "id": f.data["id"],
            "props": f.data["props"]
          });
        });
      });

      return list;
    } catch (e) {
      return null;
    }
  }
}
