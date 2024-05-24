import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:comp7705_chatbot/components/received_message_screen.dart';
// import 'package:comp7705_chatbot/components/send_message_screen.dart';
import 'package:comp7705_chatbot/service/HttpService.dart';

class Message {
  String chatBotId;
  String content;
  DateTime timestamp;

  Message({required this.chatBotId, required this.content, required this.timestamp});
}

class ChatRepository {
  static ChatRepository? _instance;

  ChatRepository._internal();

  factory ChatRepository() {
    _instance ??= ChatRepository._internal();
    return _instance!;
  }

  Future<List<Message>> fetchChatList(String userId) async {
    print('====fetchList======' + userId);
    final httpService = HttpService();
    try {
      Map<String, String> params = {'user_id': userId};
      final response = await httpService.get('http://10.0.2.2:8000/chat/list', params);
      print(response);

      List<dynamic> dataList = response['data'] as List<dynamic>;
      List<Message> chatList = [];
      for (List<dynamic> item in dataList) {
        int chatbot_id = item[0] as int;
        String timestamp = item[1] as String;
        String content = item[2] as String;
        Message message = Message(chatBotId: chatbot_id.toString(), content: content, timestamp: DateTime.parse(timestamp));
        chatList.add(message);
        print('Chatbot ID: $chatbot_id, Timestamp: $timestamp, Content: $content');
      }
      return chatList;

    } on HttpException catch (e) {
      throw HttpException('GetChatList Failed');
    } finally {
    }
  }

}




class ChatDetail extends StatefulWidget {
  ChatDetail({required Key key}) : super(key: key);

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
        //title: Text(widget.title),
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