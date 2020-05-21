import 'package:firebase_auth/firebase_auth.dart';
import 'package:instacook/models/User.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Transform firebase user in our User Model
  User _userFromFirebaseUser(FirebaseUser user){
    // ir buscar username com base no uid ou email
    return user != null ? User(email: user.email, uid: user.uid, username: "Tadeu17"): null;
  }

  //Sign in Email e Password
  Future signInEmailPassword(String email, String password)async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(error){
      print(error);
      return null;
    }
  }
  //Register
  Future registEmailPassword(String email, String password, String username)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // guardar o username com o uid na base de dados
      return _userFromFirebaseUser(user);
    }catch(error){
      print(error);
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try{
      await _auth.signOut();
    }catch(error){
      print(error);
      return null;
    }
  }
}