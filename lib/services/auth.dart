import 'package:firebase_auth/firebase_auth.dart';
import 'package:instacook/services/userService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userService = UserService();

  //CURRENT
  Future<String> getCurrentUser() async {
    try{
      var result = await _auth.currentUser();
      var user = result.uid;
      return user;
    }catch (e){
      print(e);
      return null;
    }
  }

  Future<bool> checkLogged()async{
    FirebaseUser res = await _auth.currentUser();
    if(res != null) return true;
    return false;
  }

  //CHANGE PASSWORD
  Future<bool> changePassword(String password) async {
    try {
      var result = await _auth.currentUser();
      result.updatePassword(password);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  //CHANGE EMAIL
  Future<bool> changeEmail(String email) async {
    try {
      var result = await _auth.currentUser();
      result.updateEmail(email);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  //DELETE
  Future<bool> deleteAccount() async {
    try {
      var result = await _auth.currentUser();
      result.delete();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  //LOGIN
  Future<bool> signInEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      print(this.getCurrentUser());
    } catch (error) {
      print(error);
      return null;
    }
  }
}
