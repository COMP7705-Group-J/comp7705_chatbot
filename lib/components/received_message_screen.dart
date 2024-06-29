
import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/components/custom_shape.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final String message;
  final String botName;
  final String date;

  const ReceivedMessageScreen({
    Key? key,
    required this.message,
    required this.botName,
    required this.date,
  }) : super(key: key);

  Widget buildAvatar(String name) {
    String initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final double avatarSize = 40.0;
    final double messageBubbleMaxWidth = MediaQuery.of(context).size.width - avatarSize - 120.0; // 气泡最大宽度和头像间距

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAvatar(botName), // 头像
        SizedBox(width: 10), // 头像和气泡之间的间距
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: messageBubbleMaxWidth,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18), // 左上角圆角
                    bottomLeft: Radius.circular(18), // 左下角圆角
                    bottomRight: Radius.circular(18), // 右下角圆角
                  ),
                ),
                padding: EdgeInsets.all(12),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              SizedBox(height: 4), // 气泡和日期之间的间距
              Padding(
                padding: EdgeInsets.only(left: 0), // 缩进以避免与头像重叠
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Text(
                    date,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



}