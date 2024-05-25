// import 'package:flutter/material.dart';
// import 'package:comp7705_chatbot/repository/Message.dart';
// import 'package:comp7705_chatbot/controller/ConversationController.dart';
// import 'package:get/get.dart';
// import 'package:comp7705_chatbot/pages/chat/chat_detail.dart';
//
// class BotPage extends StatefulWidget {
//   const BotPage({super.key});
//
//   @override
//   State<BotPage> createState() => _BotPageState();
// }
//
// class MessageListItem extends StatelessWidget {
//   final Message message;
//
//   MessageListItem({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(child: Text(message.chatBotId)),
//       title: Text(message.chatBotId),
//       subtitle: Text(
//         '${message.content}\n${message.timestamp.toLocal().toString().split(' ')[0]}',
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//       ),
//       trailing: Icon(Icons.arrow_forward_ios),
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => ChatDetail(userId: '1', botId: message.chatBotId),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class MessageListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ConversationController controller = Get.find<ConversationController>();
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat List')),
//       body: ListView.builder(
//         itemCount: controller.chatList.length,
//         itemBuilder: (context, index) {
//           return MessageListItem(message: controller.chatList[index]);
//         },
//       ),
//     );
//   }
// }
//
//
// class _BotPageState extends State<BotPage> {
//   final ConversationController controller = Get.find<ConversationController>();
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.getChatList('1');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Bot List')),
//       body: Obx(() =>ListView.builder(
//         controller: scrollController,
//         itemCount: controller.chatList.length,
//         itemBuilder: (context, index) {
//           return MessageListItem(message: controller.chatList[index]);
//         },
//       )),
//     );
//   }
// }