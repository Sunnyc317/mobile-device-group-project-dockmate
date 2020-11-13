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
import './message.dart';
import '../model/chat.dart';
import '../utils/sampleData.dart';
import '../utils/bottombar.dart';
import '../model/firebaseChat.dart';
import 'package:firebase_core/firebase_core.dart';

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

class Chatroom extends StatefulWidget {
  String title;
  Chatroom({this.title});
  Chat roomInfo;
  Chatroom.create({this.roomInfo});
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  final ChatFirebase firebaseDB = ChatFirebase();

  _createNewChatroom() {
    //Will ideally check against existing users and all that
    //but for now will just create a blank chatroom
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessageRoom()),
    );
  }

  Widget _fillChatroom() {
    //sample
    return StreamBuilder(
        stream: firebaseDB.getChatStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatroomTile(
                      chatroomData: Chat.startChatRoom(
                        imageURL: snapshot.data.documents[index]['imageURL'],
                        stringUsers:
                            snapshot.data.documents[index]['users'].map((item) {
                          return item.toString();
                        }).toList(),
                        lastMessage: "hardcoded last message for now",
                      ),
                      chatroomID: snapshot.data.documents[index].id);
                });
          } else {
            print("No chat snapshot has no data");
            return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15),
                child: Column(children: <Widget>[
                  ChatroomTile(chatroomData: sampleChatTile),
                  ChatroomTile(chatroomData: sampleChatTile),
                  ChatroomTile(chatroomData: sampleChatTile),
                ]));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    _buildMessageRoom() {
      if (widget.roomInfo != null) {
        print("Wicked Chat");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageRoom()),
        );
        return Scaffold();
      }
      return Center(child: _fillChatroom());
    }

    Map<String, dynamic> sampleChat = {
      "imageURL": "https://via.placeholder.com/150",
      "messages": [
        samplemessage1,
        samplemessage2,
        samplemessage3,
        samplemessage4
      ],
      "users": [mainUser, otherUser],
      "lastMessage": "testing chatroom creation",
    };

    Map<String, dynamic> samplecoll = {
      "uwu": "uwuness",
      "uwu2": "screw it have a string",
      "tryArray": ["hee", "huu"],
      "timeu": Timestamp.now(),
    };

    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("SNAPSHOT HAS ERROR ${snapshot.error}");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("WE GOT IN CHAT");
          return Scaffold(
            appBar: AppBar(
              title: Text('Chat'),
            ),
            body: _buildMessageRoom(),
            bottomNavigationBar: BottomBar(bottomIndex: 2),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _createNewChatroom(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
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
            onPressed: _createNewChatroom(),
          )
        ],
      ),
      body: Center(child: Text("Just checking that it works")),
      // child: chatStreamBuilder(), //populate if some chat data already exist
      // ),
      bottomNavigationBar: BottomBar(bottomIndex: 0),
    );
  }
}
