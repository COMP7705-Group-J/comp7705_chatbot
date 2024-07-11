import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:comp7705_chatbot/const.dart';
import 'package:http/http.dart' as http;

class HttpService {
  //final http.Client _client = http.Client();
  static IOClient _createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Trust self-signed certificates
        return true;
      };

    return IOClient(httpClient);
  }

  Future<Map<String, dynamic>> getWithO(String url) async {
    print('Http get, url: $url');

    final httpClient = _createHttpClient();
    final response = await httpClient.get(Uri.parse(url));
    print('response: $response');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException('GET request failed with status ${response.statusCode}.');
    }
  }

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

    final httpClient = _createHttpClient();
    final response = await httpClient.get(Uri.parse(url));
    print('response:' + response.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException('GET request failed with status ${response.statusCode}.');
    }
  }


  Future<Map<String, dynamic>> post(String url, Map<String, Object> body) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    final encodedBody = jsonEncode(body);
    final httpClient = _createHttpClient();
    final response = await httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: encodedBody
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException('POST request failed with status ${response.statusCode}.');
    }
  }

  Future<Map<String, dynamic>> postByForm(String url, Map<String, Object> formData) async {
    final uri = Uri.parse(url);
    final queryParameters = formData.entries.map((entry) =>
    '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value.toString())}'
    ).join('&');
    final httpClient = _createHttpClient();
    final response = await httpClient.post(uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: queryParameters
    );
    print('resodfvb'+response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException('POST request failed with status ${response.statusCode}.');
    }
  }




  void close() {
     _createHttpClient().close();
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

//test
void main() async {
  final httpService = HttpService();
  try {
    // Map<String, String> params = {'user_id': '1'};
    // final resultGet = await httpService.get(proApiUrl + 'chat/list', params);
    // print(resultGet);
    // List<dynamic> dataList = resultGet['data'] as List<dynamic>;
    // for (List<dynamic> item in dataList) {
    //   int chatbot_id = item[0] as int;
    //   String timestamp = item[1] as String;
    //   String content = item[2] as String;
    //   http://localhost:8080//chat/newChat?userId=1&chatbot_id=1&input=hi
    //   print('Chatbot ID: $chatbot_id, Timestamp: $timestamp, Content: $content');
    // }
    final body = {
      "user_id": 1,
      "chatbot_id": 1,
      "input": 'Hi!'
    };
    print(body);
    final resultPost = await httpService.postByForm(
        proApiUrl + 'chat/new_chat',
        body
    );
    print(resultPost);
  } on HttpException catch (e) {
    print(e);
  } finally {
  }
}

