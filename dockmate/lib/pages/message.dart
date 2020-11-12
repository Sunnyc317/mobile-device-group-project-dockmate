import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/message.dart';
import 'package:dockmate/utils/sampleData.dart';
import 'package:dockmate/model/chat.dart';
import '../model/firebaseChat.dart';

//while this is the internal page of chatting
class MessageRoom extends StatefulWidget {
  Chat roomInfo;
  MessageRoom();
  MessageRoom.create({this.roomInfo});
  @override
  _MessageRoomState createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  Widget populateExistingMessages() {
    //ideally this calls the DB, get the messages, return streambuilder
    //for now just return sad looking messages

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            MessageTile(msg: samplemessage1),
            // MessageTile(msg: samplemessage2),
            MessageTile(msg: samplemessage3),
            MessageTile(msg: samplemessage4),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final ChatFirebase firebaseDB = ChatFirebase();

    if (widget.roomInfo != null) {
      print("Wicked");
      firebaseDB.createChatRoom(widget.roomInfo.toMap());
    }

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
      body: Form(
        key: _formKey,
        child: Stack(children: <Widget>[
          populateExistingMessages(),
          Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              alignment: Alignment.bottomCenter,
              child: Container(
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(colors: [
                  //   Colors.grey[100],
                  //   Colors.grey[200],
                  // ])),
                  // color: Colors.grey[400],
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
                            borderRadius: BorderRadius.circular(12.7)),
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
        // Column(children: <Widget>[
        //   Center(child: Text("Image of the recipient")),
        //   populateExistingMessages(),
        //   Text("Hey this is for message"),
        //   Container(
        //       alignment: Alignment.bottomCenter,
        //       child: Text("What should be the enter message thing"))
        // ])
      ),
      bottomNavigationBar: BottomBar(
        bottomIndex: 2,
      ),
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
        "margin": EdgeInsets.only(left: 180, right: 8),
        "textAlign": TextAlign.right,
      },
      1: {
        "borderColour": Colors.green[300],
        "alignment": Alignment.topLeft,
        "padding": EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 20),
        "margin": EdgeInsets.only(left: 8, right: 180),
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
              margin: userSpecific[user]["margin"],
              alignment: userSpecific[user]["alignment"],
              padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: Text(
                msg.time.toString(),
                textAlign: TextAlign.left,
              )),
        ],
      ));
    }

    return basicBox();
  }
}
