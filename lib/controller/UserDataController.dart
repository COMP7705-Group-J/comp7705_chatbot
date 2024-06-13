import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataController {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('token');
  }

  static Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('userid', userId);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userid');
  }


  static Future<void> clearData() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //调用api
  String token = 'your_token_here';
  String userId = 'your_user_id_here';

  // 存储token和userid
  await UserDataController.saveToken(token);
  await UserDataController.saveUserId(userId);

  String? retrievedToken = await UserDataController.getToken();
  String? retrievedUserId = await UserDataController.getUserId();
  print('Token: $retrievedToken');
  print('User ID: $retrievedUserId');

}

