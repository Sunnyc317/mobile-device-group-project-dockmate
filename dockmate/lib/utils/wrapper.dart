import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/pages/firstScreen.dart';
import 'package:dockmate/pages/listings.dart';
// import 'package:dockmate/pages/my_listing.dart';
// import 'package:dockmate/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<usermodel.User>(context);
    // get the user object as in user.dart

    if (user != null) {
      return Listings(title: 'My listing', user: user);
    } else {
      return FirstScreen(title: 'Dockmate! (Authentication');
    }

    print(user);
    // return FirstScreen(title: 'Authentication');
    // return MyListing(title: "My Listing");
  }
}