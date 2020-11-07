import 'package:flutter/material.dart';
import '../utils/bottombar.dart';

class Map extends StatefulWidget {
  String title;
  Map({this.title});
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Center(
        child: Text("Placeholder for map"),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 1),
    );
  }
}
