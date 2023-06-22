import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId, senderEmail, receiverId, message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  /// convert to a map
  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'senderEmail': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
