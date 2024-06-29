import 'dart:convert';
import 'package:comp7705_chatbot/controller/UserDataController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _username = '';
  String _email = '';
  int _userId = 0;
  String _accessToken = '';

  @override
  void initState() {
    super.initState();
    _getUserId();
    _getAccessToken();
  }

  Future<void> _getUserId() async {
    int? userId = await UserDataController.getUserId();
    setState(() {
      _userId = userId ?? 0;
    });
  }

  Future<void> _getAccessToken() async {
    String? accessToken = await UserDataController.getToken();
    setState(() {
      _accessToken = accessToken ?? '';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
              controller: TextEditingController(text: _username),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              controller: TextEditingController(text: _email),
            ),
            SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: _updateUserInfo,
            //   child: Text('Update'),
            // ),
          ],
        ),
      ),
    );
  }
}