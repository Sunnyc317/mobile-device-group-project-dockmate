import 'package:flutter/material.dart';

//so this may be the preview tiles
class ChatRoomsTile extends StatefulWidget {
  @override
  _ChatRoomsTileState createState() => _ChatRoomsTileState();
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//while this is the internal page of chatting
class MessageRoom extends StatefulWidget {
  @override
  _MessageRoomState createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Hey this is for message"));
  }
}

//individual message can be stateless
class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Hey this is for message"));
  }
}
