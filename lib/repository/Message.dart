import 'package:flutter/material.dart';
import 'dart:async';

class Message {
  String conversationId;
  String bot;
  String content;
  DateTime timestamp;

  Message({required this.conversationId, required this.bot, required this.content, required this.timestamp});
}

//Mock Data
List<Message> messages = [
  Message(conversationId: "1", bot: "LinaBell", content: "Hello, how are you?", timestamp: DateTime.now().subtract(Duration(days: 1))),
  Message(conversationId: "2", bot: "CookieAnn", content: "I'm fine, thanks for asking.", timestamp: DateTime.now().subtract(Duration(hours: 2))),
  Message(conversationId: "3", bot: "Micky", content: "Glad to hear that!", timestamp: DateTime.now().subtract(Duration(minutes: 10))),
  //
];


class MessageDetailPage extends StatelessWidget {
  final Message message;

  MessageDetailPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('message page')
            // Text('Sender: ${message.bot}'),
            // const SizedBox(height: 16.0),
            // Text('Content: ${message.content}'),
            // const SizedBox(height: 16.0),
            // Text('Timestamp: ${message.timestamp.toLocal()}'),
          ],
        ),
      ),
    );
  }
}