import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  DocumentReference chatroomID;
  DocumentReference messageID;
  int by; //user index?
  String content;
  DateTime time; // not sure yet
  Timestamp timestamp;

  Message({this.content, this.by, this.time});
  Message.timestamp({this.content, this.by, this.timestamp});

  toMap() {
    return {
      "content": this.content,
      "by": this.by,
      "time": this.timestamp,
    };
  }
}
