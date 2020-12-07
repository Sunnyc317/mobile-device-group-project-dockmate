import 'package:dockmate/pages/authentication/login.dart';
import 'package:dockmate/pages/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/pages/authentication/firstScreen.dart';

// Authenticate is for toggling between login and register
class ToggleAuthScreens extends StatefulWidget {
  @override
  _ToggleAuthScreensState createState() => _ToggleAuthScreensState();
}

class _ToggleAuthScreensState extends State<ToggleAuthScreens> {
  bool showSignIn = true;
  String screen = 'firstScreen';

  void toggleView(String scr) {
    // setState(() => showSignIn = !showSignIn);
    setState(() => screen = scr);
  }

  @override
  Widget build(BuildContext context) {
    if (screen == 'firstScreen') {
      return FirstScreen(
        toggleView: toggleView,
      );
    } else if (screen == 'login') {
      return Login(toggleView: toggleView);
    } else if (screen == 'register') {
      return Register(toggleView: toggleView);
    }

    // if (showSignIn) {
    //   return Login();
    // } else {
    //   return Register();
    // }
  }
}
