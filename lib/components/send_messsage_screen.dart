
import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/components/custom_shape.dart';

class SentMessageScreen extends StatelessWidget {
  final String message;
  final String date;
  const SentMessageScreen({
    Key ? key,
    required this.message,
    required this.date
  }) : super(key: key);


  Widget buildAvatar() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/icons/girl1.png'),
      radius: 22.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 假设 avatarSize 是头像的宽度
    final double avatarSize = 40.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 气泡和日期的容器
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 气泡
              Container(
                margin: EdgeInsets.only(right: 10.0),
                constraints: BoxConstraints(
                  // 设置气泡的最大宽度
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0), // 左上角圆角
                    bottomLeft: Radius.circular(16.0), // 左下角圆角
                    bottomRight: Radius.circular(16.0), // 右下角圆角
                  ),
                ),
                padding: EdgeInsets.all(12.0),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              // 日期
              Padding(
                padding: EdgeInsets.only(right:  16.0, top: 4.0), //缩进以避免与头像重叠
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
        buildAvatar(),

      ],
    );
  }



}