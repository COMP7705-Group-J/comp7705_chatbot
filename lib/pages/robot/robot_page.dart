import 'package:comp7705_chatbot/pages/robot/botdetail.dart';
import 'package:comp7705_chatbot/pages/robot/create_robot.dart';
import 'package:flutter/material.dart';

class RobotPage extends StatefulWidget {
  const RobotPage({super.key});

  @override
  State<RobotPage> createState() => _RobotPageState();
}

class _RobotPageState extends State<RobotPage> {
  @override
  Widget build(BuildContext context) {
   return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateBotPageUI()),
              );
            },
            child: Text('Create Bot'),
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              // 添加第二个按钮的点击事件
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BotDetailsScreen(userId: 0, botId: 0)),
              );
            },
            child: Text('bots details'),
          ),
        ],
      ),
    );
  }
}