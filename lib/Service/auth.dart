import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamdrt/Screens/Authenticate/Login.dart';
import 'package:teamdrt/Screens/Authenticate/Login_Signup.dart';
import 'package:teamdrt/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User2 _userFromFirebaseUser(User user) {
    return user != null ? User2(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User2> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //sign in with google
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result= await FirebaseAuth.instance.signInWithCredential(credential);
    User user = result.user;
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    return _userFromFirebaseUser(user);
  }



  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken _accessToken = await FacebookAuth.instance.login(loginBehavior:LoginBehavior.WEB_VIEW_ONLY);

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(_accessToken.token);

    // Once signed in, return the UserCredential
    UserCredential result2= await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    User user = result2.user;
    return _userFromFirebaseUser(user);
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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
