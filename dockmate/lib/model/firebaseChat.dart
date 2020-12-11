import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebase {
  String _chatRoomID;

  //Sample placeholder data
  var submap1 = {
    "content": "Hello!",
    "by": 1,
    "time": Timestamp.now(),
  };
  var submap3 = {
    "content":
        '''Welcome to Dock Mate! I'm Shorsh, your friendly seahorse guide!
Since you are not a registered user, I can't let you contact the landlord just yet.

However, you can ask me how to register for an account, or you can ask me about the weather! :)''',
    "by": 1,
    "time": Timestamp.now(),
  };
  var submap4 = {
    "content":
        '''Welcome back to Dock Mate! I'm still Shorsh, your friendly seahorse guide!\n\nHow can I help?''',
    "by": 1,
    "time": Timestamp.now(),
  };
  var chatmap1 = {
    "imageURL": "assets/shorsh.png",
    "users": ["Self", "Shorsh"],
    "title": "Your friendly seahorse mate"
  };

  getChatRoomID() => _chatRoomID;

  Future<void> createEmptyRoom(String self) async {
    // Create empty room, only for guest chatbot instance
    chatmap1["users"] = [self, "Shorsh"];
    await FirebaseFirestore.instance
        .collection("chatroom")
        .doc("Shorsh" + self)
        .set(chatmap1)
        .then((value) async {
      _chatRoomID = "Shorsh" + self;

      // Add placeholder message depending on entrance
      String check = await checkExistence(_chatRoomID, self);
      if (check == "FromShorsh") {
        addMessage(_chatRoomID, submap4);
      } else {
        addSpecificMessage(_chatRoomID, "FromShorsh", submap3);
      }
    });
    print("The room id: $_chatRoomID");
  }

  Future<String> checkExistence(_chatRoomID, user) async {
    // This helps to check whether user talks to chatbot the first time or not
    var ss = await getMessage(_chatRoomID);
    String returnNull = "";
    ss.docs.forEach((doc) {
      if (doc.id == "FromShorsh") {
        returnNull = doc.id;
      }
    });
    return returnNull;
  }

  Future<void> createChatRoom(Map<String, dynamic> chat) async {
    // Creates a chatroom from any other entrance (so non guest user)
    await FirebaseFirestore.instance
        .collection("chatroom")
        .add(chat)
        .then((value) {
      _chatRoomID = value.id;
      addMessage(_chatRoomID, submap1);
    });
  }

  Future<QuerySnapshot> getMessage(chatroomID) async {
    // Retrieve all messages of a specific chatroom
    return await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomID)
        .collection('messages')
        .get();
  }

  Stream getMessageStream(chatroomID) {
    // Return message stream to be used by StreamBuilder
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomID)
        .collection('messages')
        .snapshots();
  }

  Stream getChatStream() {
    // Return chat stream to be used by StreamBuilder
    return FirebaseFirestore.instance.collection("chatroom").snapshots();
  }

  void addMessage(roomID, msg) {
    // Add a message to a specific chatroom
    var chatroomRef = FirebaseFirestore.instance
        .collection("chatroom")
        .doc(roomID)
        .collection('messages')
        .doc();
    chatroomRef.set(msg);
  }

  void addSpecificMessage(roomID, msgID, msg) {
    // Add a message with specific message ID to a specific chatroom
    var chatroomRef = FirebaseFirestore.instance
        .collection("chatroom")
        .doc(roomID)
        .collection('messages')
        .doc(msgID);
    chatroomRef.set(msg);
  }

  void deleteChatroom(roomID) {
    // Delete an entire chatroom
    FirebaseFirestore.instance.collection("chatroom").doc(roomID).delete();
  }
}
