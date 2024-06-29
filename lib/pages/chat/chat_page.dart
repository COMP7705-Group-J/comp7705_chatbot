import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/repository/Message.dart';
import 'package:comp7705_chatbot/controller/ConversationController.dart';
import 'package:get/get.dart';
import 'package:comp7705_chatbot/pages/chat/chat_detail.dart';
import 'package:comp7705_chatbot/controller/UserDataController.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class MessageListItem extends StatelessWidget {
  final Message message;
  String userId = '';

  MessageListItem({required this.message, required this.userId});


  Widget buildAvatar(String name) {
    String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildAvatar(message.chatBotName),
      title: Text(message.chatBotName),
      subtitle: Text(
        '${message.content}\n${message.timestamp.split(' ')[0]}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatDetail(userId: userId,
                botId: message.chatBotId,
                botName: message.chatBotName),
          ),
        );
      },
    );
  }
}

class MessageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConversationController controller = Get.find<ConversationController>();
    return Scaffold(
      appBar: AppBar(title: Text('Chat List')),
      body: ListView.builder(
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          //return MessageListItem(message: controller.chatList[index],userId: _userId);
        },
      ),
    );
  }
}


class _ChatPageState extends State<ChatPage> {
  final ConversationController controller = Get.find<ConversationController>();
  final ScrollController scrollController = ScrollController();
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _retrieveAndUseUserId();
  }


  Future<String> _getUserId() async {
    int ? userId = await UserDataController.getUserId();
    if (userId != 0) {
      setState(() {
        _userId = userId.toString();
      });
    }
    return _userId;
  }

  Future<void> _retrieveAndUseUserId() async {
    await _getUserId();
    controller.getChatList(_userId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Message List')),
      body: Obx(() =>ListView.builder(
        controller: scrollController,
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: controller.chatList[index], userId: _userId);
        },
      )),
    );
  }
}