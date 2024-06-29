import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comp7705_chatbot/service/HttpService.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:comp7705_chatbot/const.dart';


class BotsService {
  static const String _baseUrl = 'http://localhost:8000';
  static final _client = http.Client();
  static  final httpService = HttpService();

  // 创建机器人
  static Future<Map<String, dynamic>> createBot({
    required int ? userId,
    required String botName,
    required int botType,
    String? botPersona,
  }) async {
    final url = Uri.parse('$_baseUrl/bots/create');
    final body = {
      'user_id': userId,
      'chatbot_name': botName,
      'chatbot_type': botType,
      if (botType == 1)'chatbot_persona': botPersona,
    };
    print(body);
    final response = await _client.post(
      url, 
      body: jsonEncode(body), 
      headers: {'Content-Type': 'application/x-www-form-urlencoded'}
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody);
    }
  }

  // 获取机器人详情
  static Future<Bot> getBotDetail(int userId, int botId) async {
    print('[BotRepository getBotDetail], params: {userId: $userId, bostId: $botId}');
    try {
      Map<String, Object> params = {'user_id': userId, 'botId': botId};
      final response = await httpService.postByForm(proApiUrl + 'bots/detail', params);
      print('response' + response.toString());

      int code = response['code'] as int;
      if (code == -1) {
        return Bot(chatbot_id: null, chatbot_name: '', chatbot_type: null);
      }
      List<dynamic> dataList = response['data'] as List<dynamic>;
      for (dynamic item in dataList) {
        int ? userId = item['user_id'];
        int chatBotId = item['chatbot_id'];
        String chatBotName = item['chatbot_name'];
        String createdAt = item['create_at'];
        int chatbotType = item['chatbot_type'];
        String chatbotPersona = item['chatbot_persona'] == null ? "" : item['chatbot_persona'];
        Bot bot = Bot(user_id: userId, chatbot_id: chatBotId, chatbot_name: chatBotName, create_at: createdAt, chatbot_type: chatbotType,
            chatbot_persona: chatbotPersona);
        print('chatBotName: $chatBotName, chatbotPersona: $chatbotPersona, chatbotType: $chatbotType');
        return bot;
      }
      return Bot(chatbot_id: null, chatbot_name: '', chatbot_type: null);
    } on HttpException catch (e) {
      throw HttpException('GetBotList Failed');
    } finally {
    }
  }

  // static Future<Map<String, dynamic>> getBotDetails({
  //   required int ? userId,
  //   required int ? botId,
  // }) async {
  //   final url = Uri.parse('$_baseUrl/bots/detail/');
  //   final body = {
  //     'user_id': userId,
  //     'chatbot_id': botId,
  //   };
  //   final response = await _client.post(url, body: jsonEncode(body), headers: {'Content-Type': 'application/x-www-form-urlencoded'});
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body) as Map<String, dynamic>;
  //   } else {
  //     final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
  //     throw HttpException(errorBody);
  //   }
  // }

  // 获取机器人列表
  static Future<Map<String, dynamic>> getBotList({
    required int userId,
  }) async {
    final url = Uri.parse('$_baseUrl/bots/list/');
    final body = {
      'user_id': userId,
    };
    final response = await _client.post(url, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody);
    }
  }

  // 删除机器人
  static Future<Map<String, dynamic>> deleteBot({
    required int ? userId,
    required int ? botId,
  }) async {
    final url = Uri.parse('$_baseUrl/bots/delete/');
    final body = {
      'user_id': userId,
      'chatbot_id': botId.toString(),
    };
    final response = await _client.post(url, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody);
    }
  }

   static void close() {
    _client.close();
  }
}
class HttpException implements Exception {
  final dynamic errorBody;

  HttpException(this.errorBody);

  @override
  String toString() {
    return 'HttpException: $errorBody';
  }
}

// Example usage
void main() async {
  try {
    // User registration
    final createResult = await BotsService.createBot(
      userId: 1,
      botName: "LinaBell",
      botType: 1,
      botPersona: 'Sherlock Holmes'
    );
    print('createResult result: $createResult');
  } on HttpException catch (e) {
    print('Error: $e');
  } finally {
    BotsService.close();
  }
}