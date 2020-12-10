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
import 'package:dockmate/pages/app_screens/message.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/firebaseChat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dockmate/model/username.dart';
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
                  child: chatroomData.imageURL.contains("assets/shorsh")
                      ? Image(
                          width: 100,
                          height: 100,
                          image: AssetImage('assets/shorsh.png'))
                      : Image.network(chatroomData.imageURL,
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
          chatroomData.chatroomIDString = chatroomID;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MessageRoom.open(roomInfo: chatroomData, type: "open")),
          );
          //and then fill up with existing messages
          //can animate it in future: https://flutter.dev/docs/cookbook/animation/page-route-animation
        });
  }
}

class UserChat extends StatefulWidget {
  String title;
  UserChat({this.title, this.toggleView});
  Chat roomInfo;
  String _user = "USER NOT FOUND";
  Function toggleView;
  UserChat.create({this.roomInfo, this.toggleView});

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final ChatFirebase firebaseDB = ChatFirebase();
  final UsernameModel _usernameModel = UsernameModel();
  int _isEmptyCount = 0;

  @override
  void initState() {
    print("User chat's init state");
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    Username name = await _usernameModel.getUsername();
    print("anything: ${name.username}");
    setState(() {
      widget._user = name.username;
    });
  }

  bool _validateUsername() {
    print("What is username? ${widget._user}");
    if (widget._user.toLowerCase().contains("guest")) {
      return false;
    }
    return true;
  }

  _createNewChatroom() {
    //Will ideally check against existing users and all that
    //but for now will just create a blank chatroom
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessageRoom()),
    );
  }

  Widget _noMail() {
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
    _isEmptyCount += 1;
    print("IS EMPTY $_isEmptyCount");
    print("length $len");
    if (_isEmptyCount == len) {
      return _noMail();
    }
    return Container();
  }

  _decider(snapshot, index) {
    var userList = snapshot.data.documents[index]['users'].map((item) {
      return item.toString();
    }).toList();
    print("USER LIST $userList");
    if (userList[0] == widget._user) {
      //supposedly this means you're the tenant
      print("it is tenant");
      return ChatroomTile(
          chatroomData: Chat.startChatRoom(
            imageURL: snapshot.data.documents[index]['imageURL'],
            stringUsers: snapshot.data.documents[index]['users'].map((item) {
              return item.toString();
            }).toList(),
            lastMessage: "tenant hardcoded last message for now",
          ),
          chatroomID: snapshot.data.documents[index].id);
    } else if (userList[1] == widget._user) {
      print("it is landlord");
      //and this means you're the landlord
      return ChatroomTile(
          chatroomData: Chat.startChatRoom(
            imageURL: snapshot.data.documents[index]['imageURL'],
            stringUsers: snapshot.data.documents[index]['users'].map((item) {
              return item.toString();
            }).toList(),
            lastMessage: "landlord hardcoded last message for now",
          ),
          chatroomID: snapshot.data.documents[index].id);
    } else {
      print("it still thinks no mail?");
      return _condNoMail(index, snapshot.data.documents.length);
    }
  }

  Widget _fillChatroom() {
    _isEmptyCount = 0;
    return StreamBuilder(
        stream: firebaseDB.getChatStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //there will always be a data, so what I should do is to check if data is placeholder or not
            if (snapshot.data.documents.length <= 1) {
              //it can only be the placeholder
              return _noMail();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    print("does it loop?");
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
      if (widget.roomInfo != null) {
        print("Wicked Chat");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageRoom()),
        );
        return Scaffold();
      }
      return Container(child: _fillChatroom());
    }

    _navigateToFAQ(Function toggle) {
      return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MessageRoom(
                  currentUser: widget._user,
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
          print("WE GOT IN CHAT");
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
