import './message.dart';

class Chat {
  //representing a single chat preview
  String imageURL; //may be placed under Message instead
  List<Message> messages;
  String lastMessage; //may not need to store separately
}

class ChatModel {}
