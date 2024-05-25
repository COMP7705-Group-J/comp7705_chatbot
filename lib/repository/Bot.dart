import 'dart:async';
import 'dart:ffi';
import 'package:comp7705_chatbot/service/HttpService.dart';

class Bot {
  int ? chatbot_id;
  String chatbot_name;
  int chatbot_type;
  String chatbot_persona;
  String create_at;
  Bot({this.chatbot_id, required this.chatbot_name, required this.chatbot_type,
    required this.chatbot_persona, required this.create_at});
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
      final response = await httpService.post('http://47.76.114.136:8000/bots/list', params);
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






}






