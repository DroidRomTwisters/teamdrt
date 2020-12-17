import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamdrt/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User2 _userFromFirebaseUser(User user) {
    return user != null ? User2(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User2> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signin using email and password

  //signin using phone number

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


}