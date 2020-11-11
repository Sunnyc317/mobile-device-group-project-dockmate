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
  Widget populateExistingMessages() {
    //ideally this calls the DB, get the messages, return streambuilder
    //for now just return sad looking messages
    return Column(
      children: <Widget>[
        Text("Some message1"),
        Text("Some message2"),
        Text("Some message3")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Padding(
                padding: EdgeInsets.only(left: 58), child: Text("John Smith"))),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 0),
              child: IconButton(
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {},
              )),
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  Icons.videocam,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ))
        ],
      ),
      body: Stack(children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            alignment: Alignment.bottomCenter,
            child: Row(children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                ),
                onPressed: () {},
              ),
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Text("What should be the enter message thing"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ]))
      ]),
      // Column(children: <Widget>[
      //   Center(child: Text("Image of the recipient")),
      //   populateExistingMessages(),
      //   Text("Hey this is for message"),
      //   Container(
      //       alignment: Alignment.bottomCenter,
      //       child: Text("What should be the enter message thing"))
      // ])
    );
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
