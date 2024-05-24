import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> get(String url, Map<String, String> params) async {
    print('Http get, url: $url, params: $params');
    if (params != null && params.isNotEmpty) {
      String queryString = params.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('&');

      if (url.contains('?')) {
        url += '&' + queryString;
      } else {
        url += '?' + queryString;
      }
    }

    final response = await _client.get(Uri.parse(url));
    print('response:' + response.toString());
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
    Map<String, String> params = {'user_id': '1'};
    final resultGet = await httpService.get('http://47.76.114.136:8000/chat/list', params);
    print(resultGet);

    List<dynamic> dataList = resultGet['data'] as List<dynamic>;

    for (List<dynamic> item in dataList) {
      int chatbot_id = item[0] as int;
      String timestamp = item[1] as String;
      String content = item[2] as String;
      http://localhost:8080//chat/newChat?userId=1&chatbot_id=1&input=hi
      print('Chatbot ID: $chatbot_id, Timestamp: $timestamp, Content: $content');
    }



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