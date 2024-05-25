import 'dart:convert';
import 'package:http/http.dart' as http;

class BotsService {
  static const String _baseUrl = 'http://47.76.114.136:8000';
  static final _client = http.Client();

  // 创建机器人
  static Future<Map<String, dynamic>> createBot({
    required int userId,
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
    final response = await _client.post(
      url, 
      body: jsonEncode(body), 
      headers: {'Content-Type': 'application/json'}
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
  static Future<Map<String, dynamic>> getBotDetails({
    required int userId,
    required int botId,
  }) async {
    final url = Uri.parse('$_baseUrl/bots/detail/');
    final body = {
      'user_id': userId,
      'chatbot_id': botId,
    };
    final response = await _client.post(url, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody);
    }
  }

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
    required int userId,
    required int botId,
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
      botName: 'My Botsherlock',
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