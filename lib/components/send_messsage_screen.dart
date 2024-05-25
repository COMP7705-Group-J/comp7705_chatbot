
import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/components/custom_shape.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentMessageScreen extends StatelessWidget {
  final String message;
  const SentMessageScreen({
    Key ? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            CustomPaint(painter: CustomShape(Colors.deepPurple!)),
            SizedBox(width: 8), // 头像和消息之间的间距
            Icon(
              FontAwesomeIcons.solidUser, // 使用Flutter内置的账号图标作为头像
              color: Colors.deepPurple,
              size: 26, // 设置图标大小
            ),
          ],
        ));

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}