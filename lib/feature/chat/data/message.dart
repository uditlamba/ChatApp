import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sender;
  final String text;
  Timestamp? timestamp;
  final bool isCurrentUser;

  Message({
    required this.sender,
    required this.text,
    required this.isCurrentUser,
    this.timestamp
  });
}