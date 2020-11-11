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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Listings'),
        toolbarHeight: 80,
        actions: [Avatar()],
      ),
      body: Center(
        child: Text("Placeholder for my listings"),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 3),
    );
  }
}

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: CircleAvatar(
        backgroundColor: Colors.grey[850],
        child: Text("A"),
      ),iconSize: 50,
    );
  }
}
