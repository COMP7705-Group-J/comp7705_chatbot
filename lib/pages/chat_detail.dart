import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/components/received_message_screen.dart';
import 'package:comp7705_chatbot/components/send_messsage_screen.dart';
import 'package:comp7705_chatbot/controller/MessageController.dart';
import 'package:get/get.dart';
import '../repository/Message.dart';

class ChatDetail extends StatefulWidget {
  ChatDetail({key, required this.userId, required this.botId}) : super(key: key);
  final String userId;
  final String botId;

  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  String ? _message;
  final TextEditingController _controller = TextEditingController();
  final MessageController controller = Get.find<MessageController>();

  List<Message> ? messageList;
  @override
  void initState() {
    super.initState();
    controller.loadAllMessages(widget.userId, widget.botId);
  }

  void _sendMessage() {
    String message = _controller.text.trim();
    print(message);
    if (message.isNotEmpty) {
      final newMessage = MessageRequest(
        chatBotId: widget.botId,
        userId: widget.userId,
        input: message,
      );
      controller.sendMessage(newMessage);
      _controller.clear();
      controller.loadAllMessages(widget.userId, widget.botId);

    }
  }


  @override
    Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text(widget.botId),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'return',
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: controller.messageList.length,
                    itemBuilder: (context, index) {
                      final message = controller.messageList[index];
                      Widget messageWidget;
                      if (message.byUser) {
                        messageWidget = SentMessageScreen(message: message.content);
                      } else {
                        messageWidget = ReceivedMessageScreen(message: message.content);
                      }
                      return messageWidget;
                    },
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          onFieldSubmitted: (message) => _message = message,
                          decoration: InputDecoration(
                            hintText: "Type your message here",
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _sendMessage,
                        child: Text("Send")
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      );
    }

  void refresh() {
    if (mounted) {
      print('[refresh]');
      setState(() {
        controller.messageList;
      });
    }
  }
}


