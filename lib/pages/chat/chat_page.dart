import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/repository/Message.dart';
import 'package:comp7705_chatbot/controller/ConversationController.dart';
import 'package:get/get.dart';
import 'package:comp7705_chatbot/pages/chat/chat_detail.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class MessageListItem extends StatelessWidget {
  final Message message;

  MessageListItem({required this.message});


  Widget buildAvatar() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/icons/bot_blue.png'),
      radius: 20.0,
    );
  }



  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildAvatar(),
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
            builder: (context) => ChatDetail(userId: '1',
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
          return MessageListItem(message: controller.chatList[index]);
        },
      ),
    );
  }
}


class _ChatPageState extends State<ChatPage> {
  final ConversationController controller = Get.find<ConversationController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.getChatList('1');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Message List')),
      body: Obx(() =>ListView.builder(
        controller: scrollController,
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: controller.chatList[index]);
        },
      )),
    );
  }
}