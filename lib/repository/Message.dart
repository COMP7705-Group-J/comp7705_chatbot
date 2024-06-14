import 'dart:async';
import 'package:comp7705_chatbot/service/HttpService.dart';

import '../const.dart';

class Message {
  String chatBotName;
  String chatBotId;
  bool byUser;
  String content;
  String timestamp;

  Message({required this.chatBotName, required this.chatBotId, required this.byUser, required this.content, required this.timestamp});
}

class MessageRequest {
  String chatBotId;
  String userId;
  String input;
  MessageRequest({required this.chatBotId, required this.userId, required this.input});
}


class ChatRepository {
  static ChatRepository? _instance;
  final httpService = HttpService();

  ChatRepository._internal();

  factory ChatRepository() {
    _instance ??= ChatRepository._internal();
    return _instance!;
  }

  Future<List<Message>> fetchChatList(String userId) async {
    print('[fetchChatList], params: {userId: $userId}');
    try {
      Map<String, String> params = {'user_id': userId};
      final response = await httpService.get(proApiUrl + 'chat/list', params);
      print('response' + response.toString());
      List<dynamic> dataList = response['data'] as List<dynamic>;
      List<Message> chatList = [];
      for (List<dynamic> item in dataList) {
        int chatbot_id = item[0] as int;
        String chatbot_name = item[1] as String;
        String timestamp = item[2] as String;
        String content = item[3] as String;
        Message message = Message(chatBotName: chatbot_name.toString(), chatBotId: chatbot_id.toString(), byUser: false, content: content, timestamp: timestamp);
        chatList.add(message);
        print('Chatbot ID: $chatbot_id, Chatbot Name: $chatbot_name, Timestamp: $timestamp, Content: $content');
      }
      return chatList;

    } on HttpException catch (e) {
      throw HttpException('GetChatList Failed');
    } finally {
    }
  }



  Future<List<Message>> getMessages(String userId, String botId) async {
    print('[loadAllMessages], params:{userId: $userId , botId: $botId}');
    try {
      Map<String, String> params = {'user_id': userId, 'chatbot_id': botId};
      final response = await httpService.get(proApiUrl + 'chat/history', params);
      print('response' + response.toString());

      List<dynamic> dataList = response['data'] as List<dynamic>;
      List<Message> messageList = [];
      for (List<dynamic> item in dataList) {
        String content = item[0] as String;
        bool by_user = item[1] as int == 1 ? true : false;

        String timestamp = item[2] as String;
        Message message = Message(chatBotId: '', chatBotName: '', byUser: by_user, content: content, timestamp: timestamp);
        messageList.add(message);
        print('by_user: $by_user, Timestamp: $timestamp, Content: $content');
      }
      return messageList;
    } on HttpException catch (e) {
      throw HttpException('getMessages Failed');
    } finally {
    }
  }

  /**
   * Send Message to Bot
   */
  Future<void> sendMessage(MessageRequest request) async {
    print('[sendMessage], params:' + request.toString());
    String userId = request.userId;
    String botId = request.chatBotId;
    String input = request.input;
    try {
      Map<String, String> params = {'user_id': userId, 'chatbot_id': botId, 'input': input};
      final response = await httpService.postByForm(proApiUrl + 'chat/new_chat', params);
      print('response' + response.toString());
      String data = response['data'] as String;

    } on HttpException catch (e) {
      throw HttpException('SendMessage  Failed');
    } finally {
    }


  }

}






