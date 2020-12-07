import 'package:firebase_auth/firebase_auth.dart';
import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/model/username.dart';
import 'package:flutter/material.dart';

/*
TO-DOs
  - change the deprecated method onAuthStateChanged to authStateChanges
*/

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UsernameModel usernameModel = UsernameModel();

  // Create user obj based on firebaseUser

  usermodel.User _userFromFirebaseUser(User user) {
    return user != null ? usermodel.User(id: user.uid) : null;
  }

  // this would pass the User object to check status

  Stream<usermodel.User> get user {
    // _auth.authStateChanges().listen((User user) {
    //   return _userFromFirebaseUser;
    // });
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    // get the user auth status and return the system User object (instead of the firebase user)
    // returns null when user sign out
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      //adding random guest username
      final tempName = "Guest " + UniqueKey().toString();
      print("Guest $tempName is in");
      usernameModel.setUsername(tempName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String fname, String lname) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      result.user.updateProfile(displayName: '$fname $lname', photoURL: null);
      usermodel.User user = _userFromFirebaseUser(
          result.user); // convert firebase User to local User model
      return {
        'user': user,
        'msg': '${result.user.displayName} registered successfully'
      };
    } catch (e) {
      print(e.toString());
      return {'user': null, 'msg': e.toString()};
    }
  }

  // sign in with email and password
  Future signinwithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      usermodel.User user = _userFromFirebaseUser(
          result.user); // convert firebase User to local User model
      return {
        'user': user,
        'msg': '${result.user.displayName} signed in successfully'
      };
    } catch (e) {
      print(e.toString());
      return {'user': null, 'msg': e.toString()};
    }
  }
}
