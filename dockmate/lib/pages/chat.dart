/*
The chat main screen

The main entry points:
1. A plus button maybe at top of page (to create new message)
  then open an empty chat form
    validate on clicking send
2. From clicking a link somewhere
  if from clicking a link somewhere, just need to digest data

*/

import 'package:flutter/material.dart';
import './message.dart';
import '../utils/bottombar.dart';

class Chat extends StatefulWidget {
  String title;
  Chat({this.title});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream chatStream;

  Widget decideChatInterface(snapshot) {
    if (snapshot.data == null) {
      return Container(child: Text("There is no chat here yet"));
    }
    return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          return ChatRoomsTile();
        });
  }

  Widget chatStreamBuilder() {
    return StreamBuilder(
      stream: chatStream,
      builder: (context, snapshot) => decideChatInterface(snapshot),
    );
  }

  createNewChatroom() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessageRoom()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: createNewChatroom(),
          )
        ],
      ),
      body: Center(
        child: chatStreamBuilder(), //populate if some chat data already exist
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }
}
