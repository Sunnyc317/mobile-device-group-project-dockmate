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
    //this should be used only for chatting with shorsh
    print("Is the empty room called?");
    chatmap1["users"] = [self, "Shorsh"];
    await FirebaseFirestore.instance
        .collection("chatroom")
        .doc("Shorsh" + self)
        .set(chatmap1)
        .then((value) async {
      _chatRoomID = "Shorsh" + self;
      //placeholder
      String check = await checkExistence(_chatRoomID, self);
      print("wat is check $check");
      if (check == "FromShorsh") {
        addMessage(_chatRoomID, submap4);
      } else {
        addSpecificMessage(_chatRoomID, "FromShorsh", submap3);
      }
    });
    print("The room id: $_chatRoomID");
  }

  Future<String> checkExistence(_chatRoomID, user) async {
    var ss = await getMessage(_chatRoomID);
    String returnNull = "";
    ss.docs.forEach((doc) {
      print("DOCID: ${doc.id}");
      if (doc.id == "FromShorsh") {
        print("IT SHOULD RETURN TRUE AT LEAST ONCE");
        returnNull = doc.id;
      }
    });
    return returnNull;
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

  Future<String> getTitle(chatroomID) async {
    await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomID)
        .get()
        .then((value) {
      print("valueee $value");
      return "uwu";
    });
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

  Future<void> addSpecificMessage(roomID, msgID, msg) {
    var chatroomRef = FirebaseFirestore.instance
        .collection("chatroom")
        .doc(roomID)
        .collection('messages')
        .doc(msgID);
    chatroomRef.set(msg);
  }

  Future<void> deleteChatroom(roomID) {
    var chatroomRef =
        FirebaseFirestore.instance.collection("chatroom").doc(roomID).delete();
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
