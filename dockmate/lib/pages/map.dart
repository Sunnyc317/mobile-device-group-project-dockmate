import 'package:flutter/material.dart';
import 'bottombar.dart';

class Map extends StatelessWidget {
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
