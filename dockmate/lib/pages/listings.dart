import 'package:flutter/material.dart';
import '../utils/bottombar.dart';

class Listings extends StatefulWidget {
  String title;
  Listings({this.title});
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
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
