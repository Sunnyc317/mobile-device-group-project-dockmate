import 'package:flutter/material.dart';
import '../utils/bottombar.dart';

class MyListing extends StatefulWidget {
  String title;
  MyListing({this.title});
  @override
  _MyListingState createState() => _MyListingState();
}

class _MyListingState extends State<MyListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Listings'),
      ),
      body: Center(
        child: Text("Placeholder for my listings"),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 3),
    );
  }
}
