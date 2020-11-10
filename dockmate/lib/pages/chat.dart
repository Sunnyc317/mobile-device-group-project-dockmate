import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';

class Chat extends StatefulWidget {
  String title;
  Chat({this.title});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text("Placeholder for chat"),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 2),
    );
  }
}
