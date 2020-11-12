import 'package:cloud_firestore/cloud_firestore.dart';
import './message.dart';
import './user.dart';

class Chat {
  //representing a single chat preview
  DocumentReference chatroomID;
  String chatroomIDString;
  String imageURL; //may be placed under Message instead
  List<Message> messages;
  List<User> users;
  List<dynamic> stringUsers;
  String lastMessage; //may not need to store separately

  Chat.startChatRoom({
    this.imageURL,
    this.stringUsers,
    this.lastMessage,
  });
  Chat({this.imageURL, this.messages, this.users, this.lastMessage});

  Map<String, dynamic> toMap() {
    return {"imageURL": this.imageURL, "users": this.stringUsers};
  }
}
