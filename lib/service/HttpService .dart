import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> get(String url) async {
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException('GET request failed with status ${response.statusCode}.');
    }
  }

  Future<Map<String, dynamic>> post(String url, Map<String, Object> body) async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final encodedBody = jsonEncode(body);

    final response = await _client.post(
      Uri.parse(url),
      headers: headers,
      body: encodedBody
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException('POST request failed with status ${response.statusCode}.');
    }
  }

  void close() {
    _client.close();
  }
}


class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return 'HttpException: $message';
  }
}

// test
void main() async {
  final httpService = HttpService();

  try {
    final resultGet = await httpService.get('http://localhost:8000/chat/history');
    print(resultGet);


    final resultPost = await httpService.post(
      'http://localhost:8000/bots/create',
      <String, Object> {"user_id":1,
        "chatbot_name":"Bot-1",
        "chatbot_type": 0},
    );
    print(resultPost);
  } on HttpException catch (e) {
    print(e);
  } finally {
  }
}