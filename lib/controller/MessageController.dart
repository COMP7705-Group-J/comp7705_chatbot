import 'dart:async';

import 'package:comp7705_chatbot/repository/Message.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var messageList = <Message>[].obs;

  static MessageController get to => Get.find();


  void loadAllMessages(String userId, String botId) async {
    print('[MessageController loadAllMessages]');
    messageList.value = await ChatRepository().getMessages(userId, botId);
    refresh();
  }


  void sendMessage(MessageRequest request) async {
    print('[MessageController sendMessage]');
    await ChatRepository().sendMessage(request);
    loadAllMessages(request.userId, request.chatBotId);
    refresh();
  }


}