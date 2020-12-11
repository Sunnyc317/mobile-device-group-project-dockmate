/*
This page deals with the Chat interface, 
what you see when you click on the Chat tab
and the representation of each chat rooms.
*/

import 'package:flutter/material.dart';
import 'package:dockmate/pages/chat/message.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/firebaseChat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dockmate/model/username.dart';

class ChatroomTile extends StatelessWidget {
  Chat chatroomData;
  String chatroomID;
  ChatroomTile({this.chatroomData, this.chatroomID});

  @override
  Widget build(BuildContext context) {
    _showWarning(BuildContext context, name, id) {
      // Show notification before deleting a chatroom
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete chatroom?'),
            content:
                Text("Are you sure you would like to remove chatroom $name"),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Yes'),
                color: Colors.blue,
                onPressed: () {
                  ChatFirebase model = ChatFirebase();
                  model.deleteChatroom(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // This portion creates each chatroom tiles
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: chatroomData.imageURL.contains("assets/shorsh")
                      ? Image(
                          width: 100,
                          height: 100,
                          image: AssetImage('assets/shorsh.png'))
                      : Image.network(chatroomData.imageURL,
                          width: 100, height: 100)),
              Container(
                  padding: EdgeInsets.only(top: 12),
                  margin: EdgeInsets.only(left: 10, right: 30),
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
        Divider(color: Colors.grey, indent: 130, endIndent: 30)
      ]),
      onTap: () {
        // Open the message corresponding to that chatroom
        chatroomData.chatroomIDString = chatroomID;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MessageRoom.open(roomInfo: chatroomData, type: "open")),
        );
      },
      onLongPress: () {
        // Show a warning before deleting the specific chatroom
        _showWarning(context, chatroomData.stringUsers[1], chatroomID);
      },
    );
  }
}

class UserChat extends StatefulWidget {
  String title;
  Function toggleView;
  UserChat({this.title, this.toggleView});
  Chat roomInfo;
  String _user = "USER NOT FOUND";
  UserChat.create({this.roomInfo, this.toggleView});

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final ChatFirebase _firebaseDB = ChatFirebase();
  final UsernameModel _usernameModel = UsernameModel();
  // int _isEmptyCount = 0;

  @override
  void initState() {
    // Set username once on creation
    print("User chat's init state");
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    // Get current username from sqflite
    Username name = await _usernameModel.getUsername();
    setState(() {
      widget._user = name.username;
    });
  }

  Widget _noMail() {
    // Ideally shown when there is zero chatrooms in the chat
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 15),
      child: Center(
          child: Column(children: [
        Image(image: AssetImage('assets/shorsh.png')),
        Text("You have no mails!")
      ])),
    );
  }

  Widget _condNoMail(index, len) {
    // An attempt to show empty page when there is zero chat room
    // Didn't quite work, so return only container for now.
    // _isEmptyCount += 1;
    // if (_isEmptyCount == len) {
    //   return _noMail();
    // }
    return Container();
  }

  Widget _decider(snapshot, index) {
    // Conditional to decide how to build the chat room tiles
    var userList = snapshot.data.documents[index]['users'].map((item) {
      return item.toString();
    }).toList();
    if (userList[0] == widget._user) {
      // To be implemented: the tenant view
      return ChatroomTile(
          chatroomData: Chat.startChatRoom(
              imageURL: snapshot.data.documents[index]['imageURL'],
              stringUsers: snapshot.data.documents[index]['users'].map((item) {
                return item.toString();
              }).toList(),
              lastMessage: "tenant hardcoded last message for now",
              title: snapshot.data.documents[index]['title']),
          chatroomID: snapshot.data.documents[index].id);
    } else if (userList[1] == widget._user) {
      // To be implemented: the landlord view
      return ChatroomTile(
          chatroomData: Chat.startChatRoom(
              imageURL: snapshot.data.documents[index]['imageURL'],
              stringUsers: snapshot.data.documents[index]['users'].map((item) {
                return item.toString();
              }).toList(),
              lastMessage: "landlord hardcoded last message for now",
              title: snapshot.data.documents[index]['title']),
          chatroomID: snapshot.data.documents[index].id);
    } else {
      // Ideally returns placeholder no-message view
      return _condNoMail(index, snapshot.data.documents.length);
    }
  }

  Widget _fillChatroom() {
    return StreamBuilder(
        stream: _firebaseDB.getChatStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.documents.length <= 1) {
              // Specifically only when there is only 1 message in the database
              // which is the placeholder
              return _noMail();
            } else {
              // Fill chat with the available chatrooms
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return _decider(snapshot, index);
                  });
            }
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    _buildMessageRoom() {
      // Build individual chat room's messages
      if (widget.roomInfo != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageRoom()),
        );
        return Scaffold();
      }
      return Container(child: _fillChatroom());
    }

    _navigateToFAQ(Function toggle) {
      // Trigger direct call to chatbot
      return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessageRoom(
                  currentUser: widget._user,
                  postTitle: "Your helpful seahorse mate",
                )),
      );
    }

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
          return Scaffold(
            appBar: AppBar(
              leading: Image.asset("assets/dock.png",
                  scale: 20, color: Colors.white),
              title: Text(widget.title),
            ),
            body: _buildMessageRoom(),
            bottomNavigationBar: BottomBar(
              bottomIndex: 2,
              toggleView: widget.toggleView,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.help),
              onPressed: () => _navigateToFAQ(widget.toggleView),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
