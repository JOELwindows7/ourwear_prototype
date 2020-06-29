import 'package:firebase_auth/firebase_auth.dart';

class AnUserID{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userID;
  Future getUserID() async{
    FirebaseUser user = await _auth.currentUser();
    String id = user.uid;
    userID = id;
  }

  String whatUserID() {
    getUserID();
    return userID;
  }
}