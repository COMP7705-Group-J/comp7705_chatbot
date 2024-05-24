import 'package:flutter/material.dart';

class ChatDetail extends StatefulWidget {
  ChatDetail({required  key, required this.userId}) : super(key: key);
  final String userId;


  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        automaticallyImplyLeading: false,
        title: Text(widget.userId),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_chat.jpg"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            // SentMessageScreen(message: "Hello"),
            // ReceivedMessageScreen(message: "Hi, how are you"),
            // SentMessageScreen(message: "I am great how are you doing"),
            // ReceivedMessageScreen(message: "I am also fine"),
            // SentMessageScreen(message: "Can we meet tomorrow?"),
            // ReceivedMessageScreen(message: "Yes, of course we will meet tomorrow"),
          ],
        ),
      ),
    );
  }
}