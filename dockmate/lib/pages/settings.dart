import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dockmate/model/user.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../utils/bottombar.dart';

class Settings extends StatefulWidget {
  String title;
  User user;
  Settings({this.title, this.user});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    showInSnackBar("Welcome! User ${widget.user.uid}!");
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: Text(value),));
  }

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    // User user = resetUser();
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), actions: [
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('logout'),
          onPressed: () async {
            await _auth.signOut();
          },
        )
      ]),
      body: Builder(
        builder: (context) => Center(
          child: Text(
              'disabled firebase in this file because for some reason firebase wasn\' recognized'),
          // child: resetUser(),
        ),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 4),
    );
  }
  // User user = new User(first_name: "default", last_name: "default", email: "default", phone: "default", password: "default");

  // Future<QuerySnapshot> getUser() async {
  //   FirebaseFirestore.initializeApp();
  //   return await FirebaseFirestore.instance
  //   .collection('User')
  //   .where('first_name', isEqualTo: 'Sunny')
  //   .get();

  // }

  // Widget resetUser() {

  //   return FutureBuilder(
  //     future: getUser(),
  //     builder: (context, snapshot) {
  //     if (snapshot.hasError) {
  //       return Text("FirebaseInitializingFail()");
  //     }
  //     if (snapshot.connectionState==ConnectionState.done) {
  //       DocumentSnapshot document = snapshot.data.docs[0];
  //       User user_ = User.fromMap(document.data(), reference: document.reference);
  //       print('here');
  //       print(user_.first_name);
  //       return Text(user_.first_name);
  //     }
  //     else {
  //       return Text("loading");
  //     }

  //   });

  // this one was to return just the User object
  // getUser().then((QuerySnapshot snapshot) {
  //   // DocumentSnapshot document = snapshot.docs;
  //   DocumentSnapshot document = snapshot.docs[0];
  //   User user_ = User.fromMap(document.data(), reference: document.reference);
  //   print('here');
  //   print(user_.first_name);
  //   return user_;

  // setState(() {
  //   user = user_;
  //   print(user.first_name);
  // });
  // .map((DocumentSnapshot document) {
  //   var user_ = User.fromMap(document.data(), reference: document.reference);
  //   return Text(user_.first_name);
  // });
  // });

  // if (!snapshot.hasData) {
  //   return Text("no user data");
  // }
  // else {
  //   // return ListView(children: snapshot.data.docs
  //   // .map((DocumentSnapshot document) {
  //   //   var user_ = User.fromMap(document.data(), reference: document.reference);
  //   //   return Text(user_.first_name);
  //   // }).toList(),
  //   // );
  // }
  // }
  // );
  // }

}
