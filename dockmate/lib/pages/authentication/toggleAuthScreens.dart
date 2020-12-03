import 'package:dockmate/pages/authentication/login.dart';
import 'package:dockmate/pages/authentication/register.dart';
import 'package:flutter/material.dart';

// Authenticate is for toggling between login and register
class ToggleAuthScreens extends StatefulWidget {
  @override
  _ToggleAuthScreensState createState() => _ToggleAuthScreensState();
}

class _ToggleAuthScreensState extends State<ToggleAuthScreens> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login();
    } else {
      return Register();
    }
  }
}
