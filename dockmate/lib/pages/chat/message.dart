/*
This page deals with individual chatroom
The messages seen and the functionality once you enter a specific chatroom
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/message.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/model/firebaseChat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MessageTile extends StatelessWidget {
  // This class handles each message block
  Message msg;
  MessageTile({this.msg});
  @override
  Widget build(BuildContext context) {
    // 0 means sender UI
    // 1 means recipient UI
    Map<int, Map> userSpecific = {
      0: {
        "borderColour": Colors.blue[400],
        "alignment": Alignment.topRight,
        "padding": EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 5),
        "margin": EdgeInsets.only(top: 10, left: 180, right: 8),
        "timeMargin": EdgeInsets.only(top: 3, left: 180, right: 4),
        "textAlign": TextAlign.right,
      },
      1: {
        "borderColour": Colors.green[300],
        "alignment": Alignment.topLeft,
        "padding": EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 20),
        "margin": EdgeInsets.only(top: 10, left: 8, right: 180),
        "timeMargin": EdgeInsets.only(top: 3, left: 4, right: 180),
        "textAlign": TextAlign.left,
      },
    };

    String _formatDate(Timestamp ts) {
      // Helps to format date to show under the messages
      var now = new DateTime.now();
      var format = new DateFormat('HH:mm a');
      var date = DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch);
      var diff = date.difference(now);
      var time = '';
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else if (diff.inDays > 1) {
        time = diff.inDays.toString() + 'DAYS AGO';
      } else {
        time = format.format(date);
      }
      return time;
    }

    Widget basicBox() {
      // Creates the respective message box
      int user = msg.by;
      return Container(
          child: Column(
        children: <Widget>[
          Container(
            padding: userSpecific[user]["padding"],
            margin: userSpecific[user]["margin"],
            alignment: userSpecific[user]["alignment"],
            decoration: BoxDecoration(
                border: Border.all(
                  color: userSpecific[user]["borderColour"],
                ),
                borderRadius: BorderRadius.circular(3)),
            child: Text(
              msg.content,
              style: TextStyle(fontSize: 15),
              textAlign: userSpecific[user]["textAlign"],
            ),
          ),
          Container(
              margin: userSpecific[user]["timeMargin"],
              alignment: userSpecific[user]["alignment"],
              padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: Text(
                (msg.time == null)
                    ? _formatDate(msg.timestamp)
                    : DateTime.fromMicrosecondsSinceEpoch(
                            msg.time.microsecondsSinceEpoch)
                        .toString(),
                textAlign: TextAlign.left,
              )),
        ],
      ));
    }

    return basicBox();
  }
}

class MessageRoom extends StatefulWidget {
  // This class handles the entire chatroom
  Chat roomInfo;
  final Function toggleView;
  final String currentUser;
  final type;
  String postTitle;
  MessageRoom({this.toggleView, this.currentUser, this.type, this.postTitle});
  // Ideally these constructors are to be used to determine types
  MessageRoom.create(
      {this.roomInfo,
      this.toggleView,
      this.currentUser,
      this.type,
      this.postTitle});
  MessageRoom.open(
      {this.roomInfo,
      this.toggleView,
      this.currentUser,
      this.type,
      this.postTitle});
  @override
  _MessageRoomState createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  final ChatFirebase firebaseDB = ChatFirebase();
  final ScrollController _scrollController = new ScrollController();
  final picker = ImagePicker();
  QuerySnapshot snapshots;
  String messageSent;
  Timestamp curTime;
  // To be implemented - sending images through chat
  File _image;

  _showWarning(BuildContext context) {
    // Show warning for features yet implemented
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('This feature is not ready yet!'),
          content: Text("Stay tuned!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay :)'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget populateExistingMessagesDefault() {
    // If there is no message yet, put a blank page
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        // Sample placeholder messages
        // MessageTile(msg: samplemessage1),
        // MessageTile(msg: samplemessage2),
        // MessageTile(msg: samplemessage3),
        // MessageTile(msg: samplemessage4),
      ]),
    );
  }

  List sortMessage(var ss) {
    // Helper function to sort and show messages in chronological order
    List messages = [];
    for (var idx = 0; idx < ss.data.documents.length; idx++) {
      Map toAdd = Message.timestamp(
              content: ss.data.documents[idx]["content"],
              timestamp: ss.data.documents[idx]["time"],
              by: ss.data.documents[idx]["by"])
          .toMap();
      messages.add(toAdd);
    }
    messages.sort((a, b) =>
        DateTime.fromMicrosecondsSinceEpoch(b['time'].microsecondsSinceEpoch)
            .compareTo(DateTime.fromMicrosecondsSinceEpoch(
                a['time'].microsecondsSinceEpoch)));
    return messages;
  }

  Widget generateTiles() {
    // The builder to generate each message tiles
    return StreamBuilder(
        stream: firebaseDB.getMessageStream(widget.roomInfo.chatroomIDString),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List messages = sortMessage(snapshot);
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                reverse: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return MessageTile(
                      msg: Message.timestamp(
                          content: messages[index]["content"],
                          by: messages[index]["by"],
                          timestamp: messages[index]["time"]));
                });
          } else {
            return populateExistingMessagesDefault();
          }
        });
  }

  void fillSnapshot(type) async {
    // Get snapshot to get the data from firestore
    QuerySnapshot tempSnapshots =
        await firebaseDB.getMessage(widget.roomInfo.chatroomIDString);
    setState(() {
      snapshots = tempSnapshots;
    });
  }

  @override
  void initState() {
    // Initially determine type of chatroom
    super.initState();
    if (widget.roomInfo != null && widget.type == "create") {
      // A chatroom is to be created from scratch with some info
      var roomMap = widget.roomInfo.toMap();
      roomMap["title"] = widget.postTitle;
      firebaseDB.createChatRoom(roomMap).then((value) {
        widget.roomInfo.chatroomIDString = firebaseDB.getChatRoomID();
        print("chatroom ${widget.roomInfo.chatroomIDString} has been set.");
        fillSnapshot("create");
      });
    } else if (widget.type == "open") {
      // There is already an existing chatroom, just open it.
      widget.postTitle = widget.roomInfo.title;
    } else if (widget.roomInfo == null) {
      //create a very blank chatroom - used for chatbot scenario
      firebaseDB.createEmptyRoom(widget.currentUser);
      //because this is for chatbot, it is hardcoded
      widget.roomInfo = Chat.startChatRoom(
          imageURL: "assets/shorsh.png",
          stringUsers: [widget.currentUser, "Shorsh"],
          title: widget.postTitle);
      setState(() {
        widget.roomInfo.chatroomIDString = "Shorsh" + widget.currentUser;
      });
    }
  }

  Future<void> response(query) async {
    // Function to handle AI response for Chatbot
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/service.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    print("AI is trying something:" + aiResponse.getListMessage().toString());
    Map<String, dynamic> toSend = Message.timestamp(
            content:
                aiResponse.getListMessage()[0]["text"]["text"][0].toString(),
            timestamp: Timestamp.now(),
            by: 1)
        .toMap();
    firebaseDB.addMessage(widget.roomInfo.chatroomIDString, toSend);
    setState(() {});
  }

  Widget _setHeader() {
    // Determines header of the chat depending on type of chat
    if (widget.roomInfo.chatroomIDString != null &&
        widget.roomInfo.chatroomIDString.contains("Shorsh")) {
      // Return Chatbot version
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 75,
                  // width: 100,
                  child: Image(image: AssetImage('assets/shorsh.png'))),
              Container(
                child: Text("Your helpful seahorse mate"),
              )
            ],
          ));
    } else {
      // Return version with title of posting dynamically added
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 75,
                  // width: 100,
                  child: Image.network(widget.roomInfo.imageURL,
                      height: 200, width: 150, fit: BoxFit.fill)),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 20),
                  padding: EdgeInsets.only(top: 9, right: 20),
                  height: 75,
                  width: 150,
                  child: widget.postTitle == null
                      ? ("Untitled posting?")
                      : Text(widget.postTitle))
            ],
          ));
    }
  }

  Future _getImage() async {
    // Half progress to be able to send images through chat
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
              title: Center(
                  child: Padding(
                      padding: EdgeInsets.only(left: 58),
                      child: Text(widget.roomInfo == null
                          ? "John Sample"
                          : widget.roomInfo.stringUsers[1]))),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        // to be impelemented
                        _showWarning(context);
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.videocam,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        //to be implemented
                        _showWarning(context);
                      },
                    ))
              ],
            ),
            body: Form(
              key: _formKey,
              child: Stack(children: <Widget>[
                _setHeader(),
                Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 45, top: 75),
                    child: generateTiles()),
                Container(
                    //the entire bottom part
                    margin: EdgeInsets.only(top: 4, left: 5, right: 5),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.grey[100],
                          Colors.grey[200],
                        ])),
                        // color: Colors.grey,
                        // height: 60,
                        child: Row(children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.blue[800],
                              size: 30,
                            ),
                            onPressed: () {
                              //to be implemented
                              _getImage();
                            },
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                          BorderRadius.circular(12.7)),
                                  child: SizedBox(
                                    width: 300,
                                    height: 37,
                                    child: TextFormField(
                                      style: TextStyle(height: 1.7),
                                      textAlign: TextAlign.justify,
                                      //will handle expanding in the future
                                      // maxLines: 3,
                                      // minLines: 1,
                                      cursorRadius: Radius.circular(300),
                                      onChanged: (String value) {
                                        messageSent = value;
                                        curTime = Timestamp.now();
                                      },
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Enter some text!";
                                        }
                                        return null;
                                      },
                                    ),
                                  )),
                              IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.blue[600],
                                  size: 28,
                                ),
                                onPressed: () {
                                  Map<String, dynamic> toSend =
                                      Message.timestamp(
                                              content: messageSent,
                                              timestamp: curTime,
                                              by: 0)
                                          .toMap();
                                  firebaseDB.addMessage(
                                      widget.roomInfo.chatroomIDString, toSend);
                                  response(messageSent);
                                  setState(() {});
                                },
                              ),
                            ],
                          )
                        ])))
              ]),
            ),
            bottomNavigationBar: (widget.toggleView != null)
                ? BottomBar(bottomIndex: 2, toggleView: widget.toggleView)
                : null,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
