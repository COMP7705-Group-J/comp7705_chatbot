import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:comp7705_chatbot/const.dart';
import 'package:http/http.dart' as http;
import 'package:comp7705_chatbot/controller/UserDataController.dart';

class AuthService {
  static IOClient _createHttpClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Trust self-signed certificates
        return true;
      };

    return IOClient(httpClient);
  }

  static Future<Map<String, dynamic>> register(
    String username,
    String password,
    String? email,
  ) async {
    final url = Uri.parse('$proApiUrl/users/register/');
    final body = {
      'username': username,
      'password': password,
      if (email != null) 'email': email,
    };

    final httpClient = _createHttpClient();
    final response = await httpClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody);
    }
  }

  static Future<Map<String, dynamic>> login(
    String usernameOrEmail,
    String password,
  ) async {
    final url = Uri.parse('$proApiUrl/login/');
    final body = {
      'username': usernameOrEmail,
      'password': password,
    };

    final httpClient = _createHttpClient();
    final response = await httpClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody['detail']);
    }
  }

  static Future<Map<String, dynamic>> updateUser(
    int userId,
    String accessToken,
    String? username,
    String? password,
    String? email,
  ) async {
    final url = Uri.parse('$proApiUrl/users/users/$userId/');
    final body = {
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
    };

    final httpClient = _createHttpClient();
    final response = await httpClient.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw HttpException(errorBody);
    }
  }

  static void close() {
    _createHttpClient().close();
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
    /*final registerResult = await AuthService.register(
      'testuser',
      'password123',
      'test@example.com',
    );
    print('Registration result: $registerResult');
    */
    // User login
    final loginResult = await AuthService.login(
      '1',
      '1',
    );
    print('Login result: $loginResult');

    // User update
    // final accessToken = loginResult['access'];
    // final updateResult = await AuthService.updateUser(
    //   1,
    //   accessToken!,
    //   'newusername',
    //   'newpassword',
    //   'newemail@example.com',
    // );
    // print('Update result: $updateResult');
  } on HttpException catch (e) {
    print('Error: $e');
  } finally {
    AuthService.close();
  }
}