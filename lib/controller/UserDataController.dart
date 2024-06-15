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

  static Future<void> saveUserId(int userId) async {
    print("saveUserId: ${userId}");

    final SharedPreferences prefs = await _prefs;
    await prefs.setInt('userid', userId);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    int ? userId = prefs.getInt('userid');
    print("GetUserId: ${userId}");
    return userId;
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
  int userId = 1;

  // 存储token和userid
  await UserDataController.saveToken(token);
  await UserDataController.saveUserId(userId);

  String? retrievedToken = await UserDataController.getToken();
  int retrievedUserId = await UserDataController.getUserId() ?? 0;
  print('Token: $retrievedToken');
  print('User ID: $retrievedUserId');

}

