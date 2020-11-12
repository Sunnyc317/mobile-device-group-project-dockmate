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
    Map<String, String> submap = {"submap sanity check": "yay"};
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
      chatroomRef.set(submap);
    });
    /*

    .collection("chatroom")
        .id(uuid)
        .setData(chat)
        .catchError((e) {
      print("Error when creating chatroom: $e");
    
    
    });
    */
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
