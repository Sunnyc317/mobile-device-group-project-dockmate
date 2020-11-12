import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatFirebase {
  // Future<DocumentReference> createChatRoom(Map<String, dynamic> chat) {
  //   FirebaseFirestore.instance.collection("chatroom").add(chat).then((value) {
  //     return value.id;
  //   });
  String _chatRoomID;

  getChatRoomID() => _chatRoomID;

  Future<void> createChatRoom(Map<String, dynamic> chat) async {
    // Map<String, String> submap = {"submap sanity check": "yay"};
    var submap1 = {
      "content": "Hello!",
      "by": 0,
      "time": Timestamp.now(),
    };
    var submap2 = {
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "by": 1,
      "time": Timestamp.now(),
    };
    await FirebaseFirestore.instance
        .collection("chatroom")
        .add(chat)
        .then((value) {
      print("Was the value ID correct to begin with? ${value.id}");
      _chatRoomID = value.id;
      var chatroomRef = FirebaseFirestore.instance
          .collection("chatroom")
          .doc(_chatRoomID)
          .collection('messages')
          .doc();
      chatroomRef.set(submap1);
      var chatroomRef2 = FirebaseFirestore.instance
          .collection("chatroom")
          .doc(_chatRoomID)
          .collection('messages')
          .doc();
      chatroomRef2.set(submap2);
      var chatroomRef3 = FirebaseFirestore.instance
          .collection("chatroom")
          .doc(_chatRoomID)
          .collection('messages')
          .doc();
      chatroomRef3.set(submap1);
      var chatroomRef4 = FirebaseFirestore.instance
          .collection("chatroom")
          .doc(_chatRoomID)
          .collection('messages')
          .doc();
      chatroomRef4.set(submap2);
    });
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

  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
