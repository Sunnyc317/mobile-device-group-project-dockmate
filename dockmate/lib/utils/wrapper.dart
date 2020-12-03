import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/pages/authentication/firstScreen.dart';
import 'package:dockmate/pages/app_screens/listings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Wrapper is for tracking the auth status and displaying different screens
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<usermodel.User>(context);
    // get the user object as in user.dart
    
    print(user);
    if (user != null) {
      print('user has signed in, should jump to listings');
      return Listings(title: 'My listing', user: user);
    } else {
      print('user = $user, not signed in');
      return FirstScreen();
    }

    print(user);
    // return FirstScreen(title: 'Authentication');
    // return MyListing(title: "My Listing");
  }
}