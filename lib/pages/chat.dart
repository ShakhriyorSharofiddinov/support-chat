import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shakhriyor_sharofiddinov/service/chat/chat_service.dart';
import 'package:shakhriyor_sharofiddinov/widgets/text_message.dart';

class ChatPage extends StatefulWidget {
  final String userEmail, userId;

  const ChatPage(this.userEmail, this.userId, {super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _message = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isDisabled = false;

  /// send message
  void sendMessage() async {
    if (_message.text.isNotEmpty) {
      await _chatService.sendMessage(widget.userId, _message.text);
      _message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          ///messages
          Expanded(
            child: _builtMessageList(),
          ),

          ///user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  /// AppBar
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green.shade700,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/img.png"),
          ),
          SizedBox(width:  10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kristin Watson",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          splashRadius: 26,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          splashRadius: 26,
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }


  /// built message list
  Widget _builtMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessage(
            widget.userId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading......");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  /// built message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    final bool isSend = (data['senderId'] == _firebaseAuth.currentUser!.uid);
    var alignment = isSend
        ? Alignment.centerRight
        : Alignment.bottomLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          TextMessage(data['message'], isSend),
        ],
      ),
    );
  }

  /// built message input
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: Colors.green),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _message,
                      decoration: const InputDecoration(
                        hintText: "Type message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  isDisabled
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.attach_file,
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                              ),
                            ),
                          ],
                        )
                      : IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: const Icon(
                            Icons.send,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
