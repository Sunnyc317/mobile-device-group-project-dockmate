import 'package:flutter/material.dart';
import 'bottombar.dart';

class Listings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listings'),
      ),
      body: Center(
        child: Text("Placeholder for listings"),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }
}
