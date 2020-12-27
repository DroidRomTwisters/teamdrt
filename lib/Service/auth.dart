import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamdrt/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;

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
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User user = result.user;
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    return _userFromFirebaseUser(user);
  }

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken _accessToken = await FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.WEB_VIEW_ONLY);

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(_accessToken.token);

    // Once signed in, return the UserCredential
    UserCredential result2 = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    User user = result2.user;
    return _userFromFirebaseUser(user);
  }

  Future signInWithTwitter() async {
    // Create a TwitterLogin instance
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'OvbbqpqsHxnd9WqyMJ1vLjj7v',
      consumerSecret: 'd9E2jVdi4tWdCihTZA2K4JACJdrRernlizz2K58nxY3Ft3u6IF',
    );

    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token, secret: twitterSession.secret);

    // Once signed in, return the UserCredential
    UserCredential result2 =
        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    User user = result2.user;
    return _userFromFirebaseUser(user);
  }

  Future signInWithGitHub(BuildContext context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: '21d6234b4eb90c7f139f',
        clientSecret: '3135e0cb423afb8be850b672b2997bad1bfebd9a',
        redirectUrl: 'https://teamdrt-280320.firebaseapp.com/__/auth/handler');
    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);
    // Create a credential from the access token
    final AuthCredential githubAuthCredential =
        GithubAuthProvider.credential(result.token);
    // Once signed in, return the UserCredential
    UserCredential result2 =
        await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
    User user = result2.user;
    return _userFromFirebaseUser(user);
  }

  Future signInWithPhoneNumber(String phone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        preferences.setString("verificationId", credential.verificationId);
        SigInwithSmsCode(credential.smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken) {
        preferences.setString("verificationId", verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future SigInwithSmsCode(String code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String verificationId = preferences.getString("verificationId");
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    User user = result.user;
    return user;
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
