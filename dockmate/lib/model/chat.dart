import 'package:cloud_firestore/cloud_firestore.dart';
import './message.dart';
import './user.dart';

class Chat {
  //representing a single chat preview
  DocumentReference chatroomID;
  String imageURL; //may be placed under Message instead
  List<Message> messages;
  List<User> users;
  String lastMessage; //may not need to store separately
}

class ChatModel {}
