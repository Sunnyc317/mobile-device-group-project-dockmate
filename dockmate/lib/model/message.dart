import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  DocumentReference chatroomID;
  DocumentReference messageID;
  int by; //user index?
  String content;
  DateTime time; // not sure yet
}
