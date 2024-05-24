import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/repository/Message.dart';
import 'package:comp7705_chatbot/controller/ConversationController.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class MessageListItem extends StatelessWidget {
  final Message message;

  MessageListItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(message.chatBotId)),
      title: Text(message.chatBotId),
      subtitle: Text(
        '${message.content}\n${message.timestamp.toLocal().toString().split(' ')[0]}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MessageDetailPage(message: message),
          ),
        );
      },
    );
  }
}

class MessageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConversationController controller = Get.find(); // 获取 ConversationController 的实例
    return Scaffold(
      appBar: AppBar(title: Text('Chat List')),
      body: ListView.builder(
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: controller.chatList[index]);
        },

      ),
    );
  }
}


class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final ConversationController controller = Get.find(); // 获取 ConversationController 的实例

    return Scaffold(
      appBar: AppBar(title: Text('Message List')),
      body: ListView.builder(
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: controller.chatList[index]);
        },

      ),
    );
    // return Center(
    //     child: MessageListItem(message: messages[index]),
    //   //child: Text('chat page'),
    // );
  }
}