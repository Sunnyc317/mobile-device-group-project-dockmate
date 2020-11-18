import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:dockmate/model/user.dart' as usermodel;

/*
TO-DOs
  - change the deprecated method onAuthStateChanged to authStateChanges
*/

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

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


  // this would pass the FirebaseUser object to check status

  // Stream<User> get user {
  //   // _auth.authStateChanges().listen((User user) {
  //   //   return _userFromFirebaseUser;
  //   // });
  //   return _auth.onAuthStateChanged;
  //   // get the user auth status and return the system User object (instead of the firebase user)
  //   // returns null when user sign out
  // }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
}