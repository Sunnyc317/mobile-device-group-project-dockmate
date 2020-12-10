import 'package:dockmate/pages/app_screens/listings.dart';
import 'package:dockmate/pages/app_screens/my_listing.dart';
import 'package:dockmate/pages/app_screens/settings.dart';
import 'package:dockmate/utils/chatWrapper.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/pages/app_screens/map.dart' as mapScreen;

// Authenticate is for toggling between login and register
class ToggleMainScreens extends StatefulWidget {
  // User user;
  // bool verified;

  // ToggleMainScreens({Key key, this.user, this.verified}):super(key:key);
  @override
  _ToggleMainScreensState createState() => _ToggleMainScreensState();
}

class _ToggleMainScreensState extends State<ToggleMainScreens> {
  String screen = 'Listings';

  void toggleView(String scr) {
    setState(() => screen = scr);
  }

  @override
  Widget build(BuildContext context) {
    if (screen == 'Listings') {
      return Listings(toggleView: toggleView);
    } else if (screen == 'Map') {
      return mapScreen.Map(toggleView: toggleView);
    } else if (screen == 'Chat') {
      return ChatWrapper(toggleView: toggleView);
    } else if (screen == 'My Listings') {
      return MyListing(toggleView: toggleView);
    } else if (screen == 'Settings') {
      return Settings(toggleView: toggleView);
    }
  }
}
