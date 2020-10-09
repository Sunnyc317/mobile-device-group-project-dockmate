import 'package:flutter/material.dart';
import 'bottombar.dart';

class MyListing extends StatelessWidget {
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
