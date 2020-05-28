import 'package:firebase_auth/firebase_auth.dart';
import 'package:instacook/services/userService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userService = userService();

  //CURRENT
  Future<String> getCurrentUser() async {
    var result = await _auth.currentUser();
    var user = result.uid;
    return user;
  }

  //LOGIN
  Future<bool> signInEmailPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  //REGISTER
  Future<bool> registEmailPassword(
      String email, String password, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      _userService.insertUser(user.uid, email, username);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print(error);
      return null;
    }
  }
}
