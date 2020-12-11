import 'package:dockmate/pages/authentication/login.dart';
import 'package:dockmate/pages/authentication/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/pages/authentication/firstScreen.dart';

// Authenticate is for toggling between login and register
class ToggleAuthScreens extends StatefulWidget {
  User user;
  bool verified;

  ToggleAuthScreens({Key key, this.user, this.verified}):super(key:key);
  @override
  _ToggleAuthScreensState createState() => _ToggleAuthScreensState();
}

class _ToggleAuthScreensState extends State<ToggleAuthScreens> {
  // bool showSignIn = true;
  String screen = 'login';

  void toggleView(String scr) {
    // setState(() => showSignIn = !showSignIn);
    setState(() => screen = scr);
  }

  @override
  Widget build(BuildContext context) {
    if (screen == 'login') {
      return Login(toggleView: toggleView, user: widget.user, verified: widget.verified);
    } else if (screen == 'register') {
      return Register(toggleView: toggleView);
    } 
    // else if (screen == 'firstScreen') {
    //   return FirstScreen(
    //     toggleView: toggleView,
    //   );
    // } 

    // if (showSignIn) {
    //   return Login();
    // } else {
    //   return Register();
    // }
  }
}
