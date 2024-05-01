import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/repository/Message.dart';

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
      leading: CircleAvatar(child: Text(message.bot[0])),
      title: Text(message.bot),
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
    return Scaffold(
      appBar: AppBar(title: Text('Chat List')),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: messages[index]);

        },

      ),
    );
  }
}


class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message List')),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: messages[index]);
        },

      ),
    );
    // return Center(
    //     child: MessageListItem(message: messages[index]),
    //   //child: Text('chat page'),
    // );
  }
}