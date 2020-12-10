/*
The chat main screen

The main entry points:
1. A plus button maybe at top of page (to create new message)
  then open an empty chat form
    validate on clicking send
2. From clicking a link somewhere
  if from clicking a link somewhere, just need to digest data

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/pages/app_screens/message.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/utils/sampleData.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/firebaseChat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dockmate/model/username.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter/scheduler.dart';

class ChatroomTile extends StatelessWidget {
  Chat chatroomData;
  String chatroomID;
  ChatroomTile({this.chatroomData, this.chatroomID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(chatroomData.imageURL,
                      width: 100, height: 100)),
              Container(
                  padding: EdgeInsets.only(top: 12),
                  margin: EdgeInsets.only(right: 60),
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: chatroomData.users != null
                              ? Text(
                                  chatroomData.users[1].first_name +
                                      chatroomData.users[1].last_name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))
                              : Text(chatroomData.stringUsers[1],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))),
                      Text(chatroomData.lastMessage),
                    ],
                  ))
            ],
          ),
        ),
        onTap: () {
          //open a message for now
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MessageRoom.create(roomInfo: chatroomData)),
          );
          //and then fill up with existing messages
          //can animate it in future: https://flutter.dev/docs/cookbook/animation/page-route-animation
        });
  }
}

class GuestChat extends StatefulWidget {
  String title;
  GuestChat({this.title});
  Chat roomInfo;
  String _user = "USER NOT FOUND";
  GuestChat.create({this.roomInfo});

  @override
  _GuestChatState createState() => _GuestChatState();
}

class _GuestChatState extends State<GuestChat> {
  final ChatFirebase firebaseDB = ChatFirebase();
  List<Object> _messages;
  final messageInsert = TextEditingController();

  @override
  void initState() {
    super.initState();
    _createNewChatroom();
  }

  _createNewChatroom() {
    //Will ideally check against existing users and all that
    //but for now will just create a blank chatroom
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // add your code here.

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessageRoom()),
      );
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MessageRoom()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // _buildMessageRoom() {
    //   if (widget.roomInfo != null) {
    //     print("Wicked Chat");
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => MessageRoom()),
    //     );
    //     return Scaffold();
    //   }
    //   return Center(child: _fillChatroom());
    // }

    void response(query) async {
      AuthGoogle authGoogle =
          await AuthGoogle(fileJson: "assets/service.json").build();
      Dialogflow dialogflow =
          Dialogflow(authGoogle: authGoogle, language: Language.english);
      AIResponse aiResponse = await dialogflow.detectIntent(query);
      setState(() {
        _messages.insert(0, {
          "data": 0,
          "message":
              aiResponse.getListMessage()[0]["text"]["text"][0].toString()
        });
      });
      print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
    }

    return Scaffold(
      // appBar: AppBar(
      //   leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
      //   title: Text('GUEST Chat'),
      // ),
      // body: _createNewChatroom(),
      bottomNavigationBar: BottomBar(bottomIndex: 2),
    );
  }
}
