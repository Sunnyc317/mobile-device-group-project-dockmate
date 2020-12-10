import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebase {
  String _chatRoomID;
  var submap1 = {
    "content": "Hello!",
    "by": 1,
    "time": Timestamp.now(),
  };
  var submap2 = {
    "content":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "by": 1,
    "time": Timestamp.now(),
  };
  var chatmap1 = {
    "imageURL": "assets/shorsh.png",
    "users": ["Self", "Shorsh"],
  };

  getChatRoomID() => _chatRoomID;

  Future<void> createEmptyRoom() async {
    //this should be used only for chatting with shorsh
    print("Is the empty room called?");
    await FirebaseFirestore.instance
        .collection("chatroom")
        .doc("Shorsh")
        .set(chatmap1)
        .then((value) {
      _chatRoomID = "Shorsh";
      //ideally this will be placeholder
      // addMessage(_chatRoomID, submap2);
    });
    print("The room id: $_chatRoomID");

    // await FirebaseFirestore.instance
    //     .collection("chatroom")
    //     .add(chatmap1)
    //     .then((value) {
    //   _chatRoomID = value.id;
    //   //ideally this will be placeholder
    //   addMessage(_chatRoomID, submap2);
    // });
    // print("The room id: $_chatRoomID");
  }

  Future<void> createChatRoom(Map<String, dynamic> chat) async {
    await FirebaseFirestore.instance
        .collection("chatroom")
        .add(chat)
        .then((value) {
      print("Was the value ID correct to begin with? ${value.id}");
      _chatRoomID = value.id;
      addMessage(_chatRoomID, submap1);
    });
    //uncomment to see scrolling
    // addMessage(_chatRoomID, submap2);
    // addMessage(_chatRoomID, submap1);
    // addMessage(_chatRoomID, submap2);
  }

  Future<QuerySnapshot> getMessage(chatroomID) async {
    print("what is chatroom ID passed: $chatroomID");
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomID)
        .collection('messages')
        .get();
  }

  Stream getMessageStream(chatroomID) {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomID)
        .collection('messages')
        .snapshots();
  }

  Stream getChatStream() {
    return FirebaseFirestore.instance.collection("chatroom").snapshots();
  }

  Future<void> addMessage(roomID, msg) {
    var chatroomRef = FirebaseFirestore.instance
        .collection("chatroom")
        .doc(roomID)
        .collection('messages')
        .doc();
    chatroomRef.set(msg);
  }

  // Future<void> deleteMessage(
  //   roomID,
  // ) {
  //   var chatroomRef = FirebaseFirestore.instance
  //       .collection("chatroom")
  //       .doc(roomID)
  //       .collection('messages')
  //       .doc();
  //   chatroomRef.set(msg);
  // }
}
