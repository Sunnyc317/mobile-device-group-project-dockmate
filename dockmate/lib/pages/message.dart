import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/message.dart';
import 'package:dockmate/utils/sampleData.dart';
import 'package:dockmate/model/chat.dart';
import 'package:dockmate/model/firebaseChat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timeago/timeago.dart' as timeago;

//while this is the internal page of chatting
class MessageRoom extends StatefulWidget {
  Chat roomInfo;
  Chat existingRoomInfo;
  String existingChatID;
  MessageRoom();
  MessageRoom.create({this.roomInfo});
  MessageRoom.open(this.existingRoomInfo, this.existingChatID);
  @override
  _MessageRoomState createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  final ChatFirebase firebaseDB = ChatFirebase();
  QuerySnapshot snapshots;

  Widget populateExistingMessages() {
    //ideally this calls the DB, get the messages, return streambuilder
    //for now just return sad looking messages

    List<Message> messageArray;
    print("JUST WANT TO CHECK THAT EVERYTHING'S WORKING");
    (snapshots == null)
        ? print("nooo snapshot is null")
        : snapshots.docs.forEach((doc) {
            Message msg = Message.timestamp(
                content: doc["content"], by: doc["by"], timestamp: doc["time"]);
            messageArray.add(msg);
            print('''content: ${doc["content"]}
            by: ${doc["by"]}
            time: ${doc["time"]}
            ''');
          });
  }

  Widget populateExistingMessagesDefault() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        MessageTile(msg: samplemessage1),
        // MessageTile(msg: samplemessage2),
        // MessageTile(msg: samplemessage3),
        // MessageTile(msg: samplemessage4),
      ]),
    );
  }

  Widget generateTiles() {
    print("would the ID logic work?");
    print(widget.existingChatID == null
        ? widget.roomInfo.chatroomIDString
        : widget.existingChatID);
    if (snapshots == null) {
      return populateExistingMessagesDefault();
    }
    return StreamBuilder(
        stream: firebaseDB.getMessageStream(widget.existingChatID == null
            ? widget.roomInfo.chatroomIDString
            : widget.existingChatID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      msg: Message.timestamp(
                          content: snapshot.data.documents[index]["content"],
                          by: snapshot.data.documents[index]["by"],
                          timestamp: snapshot.data.documents[index]["time"]));
                });
          } else {
            print("No snapshot has no data");
            return Container();
          }
        });
  }

  fillSnapshot(type) async {
    if (type == 'create') {
      QuerySnapshot tempSnapshots =
          await firebaseDB.getMessage(widget.roomInfo.chatroomIDString);
      setState(() {
        snapshots = tempSnapshots;
      });
      print("creating");
    } else {
      QuerySnapshot tempSnapshots =
          await firebaseDB.getMessage(widget.existingChatID);
      setState(() {
        snapshots = tempSnapshots;
      });
      print("existing");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    //need more robust handling in future
    //(check if the chatroom has already existed)
    if (snapshots == null && widget.existingRoomInfo == null) {
      print("Wicked");
      firebaseDB.createChatRoom(widget.roomInfo.toMap()).then((value) {
        widget.roomInfo.chatroomIDString = firebaseDB.getChatRoomID();
        print("set up chatroomID be ${widget.roomInfo.chatroomIDString}");
        fillSnapshot("create");
      });
    } else {
      print("not wicked");
      // fillSnapshot("not");
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
          print("WE GOT IN MESSAGES");
          return Scaffold(
            appBar: AppBar(
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
                      onPressed: () async {
                        // to be impelemented
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
                      },
                    ))
              ],
            ),
            body: Form(
              key: _formKey,
              child: Stack(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 45),
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
                            onPressed: () {},
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
                                      onChanged: (String value) {},
                                      validator: (String value) {
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
                                onPressed: () {},
                              ),
                            ],
                          )
                        ])))
              ]),
            ),
            bottomNavigationBar: BottomBar(
              bottomIndex: 2,
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class MessageTile extends StatelessWidget {
  Message msg;
  MessageTile({this.msg});
  @override
  Widget build(BuildContext context) {
    //so will return left or right depending on user index
    //try to keep user index 0 as the sender
    //and user index 1 as the recipient

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

    Widget basicBox() {
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
                    ? timeago.format(msg.timestamp
                        .toDate()) //will work on different time display later
                    : msg.time.toString(),
                textAlign: TextAlign.left,
              )),
        ],
      ));
    }

    return basicBox();
  }
}
