import 'dart:async';
import 'dart:ffi';
import 'package:comp7705_chatbot/service/HttpService.dart';

class Bot {
  int ? user_id;
  int ? chatbot_id;
  String chatbot_name;
  int chatbot_type;
  String ? chatbot_persona;
  String ? create_at;
  Bot({this.user_id,this.chatbot_id, this.create_at,this.chatbot_persona,required this.chatbot_name, required this.chatbot_type,
     });
}

class BotRequest {
  String ? chatbot_name;
  int ? chatbot_type;
  String ? chatbot_persona;
  BotRequest({ this.chatbot_name, this.chatbot_type, this.chatbot_persona});
}


class BotRepository {
  static BotRepository? _instance;
  final httpService = HttpService();

  BotRepository._internal();

  factory BotRepository() {
    _instance ??= BotRepository._internal();
    return _instance!;
  }

  Future<List<Bot>> getBotList(String userId) async {
    print('[BotRepository getBotList], params: {userId: $userId}');
    try {
      Map<String, String> params = {'user_id': userId};
      final response = await httpService.postByForm('http://47.76.114.136:8000/bots/list', params);
      print('response' + response.toString());
      List<Bot> botList = [];

      int code = response['code'] as int;
      if (code == -1) {
        return botList;
      }
      List<Bot> dataList = response['data'] as List<Bot>;
      for (Bot item in dataList) {
        String chatBotName = item.chatbot_name;
        String createdAt = item.create_at;
        int chatbotType = item.chatbot_type;
        String chatbotPersona = item.chatbot_persona;
        Bot bot = Bot(chatbot_name: chatBotName, create_at: createdAt, chatbot_type: chatbotType,
          chatbot_persona: chatbotPersona);
        botList.add(bot);
        print('chatBotName: $chatBotName, chatbotPersona: $chatbotPersona, chatbotType: $chatbotType');
      }
      return botList;

    } on HttpException catch (e) {
      throw HttpException('GetBotList Failed');
    } finally {
    }
  }

  Future<int> createBot(Bot bot) async {
    Map<String, String> botparams = {
      'user_id': bot.user_id.toString(),
      'chatbot_name': bot.chatbot_name,
      'chatbot_type': bot.chatbot_type.toString(),
      if (bot.chatbot_type == 1) 'chatbot_persona': bot.chatbot_persona ?? '',
    };
    print('[BotRepository createBot], params: $botparams');
    try {
      final response = await httpService.postByForm('http://47.76.114.136:8000/bots/create', botparams);
      print('response' + response.toString());
      int code = response['code'] as int;
      print('code' + code.toString());
      if (code == -1) {
        throw HttpException('Create Bot Failedhhhh');
      }
      List<dynamic> dataList = response['data'];
      Map<String, dynamic> dataMap = dataList.first as Map<String, dynamic>;
      int chatbotId = dataMap['chatbot_id'] as int;
      //String createdAt = data['create_at'] as String;
      return chatbotId;
    } on HttpException {
      rethrow;
    } catch (e) {
      throw HttpException('Create Bot Failed');
    }
  }




}






