
import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/components/custom_shape.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final String message;
  const ReceivedMessageScreen({
    Key? key,
    required this.message,
  }) : super(key: key);

  Widget buildAvatar() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/icons/bot_grey.png'),
      //radius: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAvatar(), //头像
            // Icon(
            //   FontAwesomeIcons.robot, // 使用Flutter内置的账号图标作为头像
            //   color: Colors.grey,
            //   size: 26, // 设置图标大小
            // ),
            SizedBox(width: 10), // 头像和消息之间的间距
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: CustomShape(Colors.grey[350]!),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ));

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
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