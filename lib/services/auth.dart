
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourwearprototype/models/user.dart';

import 'package:ourwearprototype/services/database.dart';

class AuthService{

  //underscore is private
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null? User(uid: user.uid): null;
  }

  // Auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      //return user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWIthEmailAndPassword(String email, String password, {String phoneNumber}) async {
    try{
      String tempNumberPhone = phoneNumber ?? '0';
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      FirebaseUser user = result.user;

      // create a new document with ui of user
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      await DatabaseService(uid: user.uid).updateWearerData('New Wearer', tempNumberPhone, 'address');
      await DatabaseService(uid: user.uid).updateCartData('New Rentee');

      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}