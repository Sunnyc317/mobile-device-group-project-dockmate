import 'dart:ffi';

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

  Stream<User> get userstatus {
    return _auth.userChanges();
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
      User user = result.user;
      user.updateProfile(displayName: '$fname $lname');

      try {
        await user.sendEmailVerification();
        // return user.uid;
      } catch (e) {
        return {
          'user': null,
          'msg':
              "An error occured while trying to send email verification \nerror message: ${e.toString()}"
        };
      }

      usermodel.User userLocal = _userFromFirebaseUser(
          user); // convert firebase User to local User model
      return {
        'user': userLocal,
        'msg':
            '${user.displayName} registered successfully, a varification email is sent to your mail box'
      };
    } catch (e) {
      print(e.toString());
      return {
        'user': null,
        'msg': 'registration unsuccessful \nerror message: ${e.toString()}'
      };
    }
  }

  // sign in with email and password
  Future signinwithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!result.user.emailVerified) {
        try {
          await result.user.sendEmailVerification();
          print('returned varification snackbar');
          return {
            'user': null,
            'msg':
                '${result.user.email} is not varified! \nAn varification email is on the way, please varify again'
          };
        } catch (e) {
          return {
            'user': null,
            'msg':
                "${result.user.email} is not varified! \nAn error occured while trying to send email verification \nerror message: ${e.toString()}"
          };
        }
      }

      // convert firebase User to local User model
      usermodel.User user = _userFromFirebaseUser(result.user);
      user.setname(result.user.displayName);
      user.setemail(result.user.email);
      user.setprofilepic(result.user.photoURL);
      user.setemailvarified(result.user.emailVerified);
      user.setphone(result.user.phoneNumber);

      return {
        'user': user,
        'msg': '${result.user.displayName} signed in successfully'
      };
    } catch (e) {
      print(e.toString());
      return {
        'user': null,
        'msg': 'can\'t sign in \nerror message: ${e.toString()}'
      };
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // print(result);
      return {
        'linksent': true,
        'msg': 'A link has been sent to $email, reset your password now!'
      };
    } catch (e) {
      return {
        'linksent': false,
        'msg': 'failed to send link to $email \nerror: ${e.toString()}'
      };
    }
  }
}
