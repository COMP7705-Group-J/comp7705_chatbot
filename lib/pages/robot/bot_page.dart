import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/controller/BotController.dart';
import 'package:get/get.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:comp7705_chatbot/pages/robot/botdetail.dart';
import 'package:comp7705_chatbot/pages/robot/create_robot.dart';
class BotPage extends StatefulWidget {
  const BotPage({super.key});

  @override
  State<BotPage> createState() => _BotPageState();
}

class BotListItem extends StatelessWidget {
  final Bot bot;

  BotListItem({required this.bot});


  Widget buildAvatar() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/icons/bot_blue.png'),
      radius: 20.0,
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildAvatar(),
      title: Text(bot.chatbot_name),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        //Navigator.of(context).push(
          // MaterialPageRoute(
          //   builder: (context) => BotDetail(botId: bot.chatbot_id.toString()),
          // ),
        //);
      },
    );
  }
}

class BotListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BotController controller = Get.find<BotController>();
    return Scaffold(
      appBar: AppBar(title: Text('Chat List')),
      body: ListView.builder(
        itemCount: controller.botList.length,
        itemBuilder: (context, index) {
          return BotListItem(bot: controller.botList[index]);
        },
      ),
    );
  }
}


class _BotPageState extends State<BotPage> {
  final BotController controller = Get.find<BotController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.getBotList('1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text('Bot List')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CreateBotPageUI()),
              //     );
              //   },
              //   child: Text('Create Chatbot'),
              // ),
              // SizedBox(width: 16.0),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => BotDetailsScreen(userId: 0, botId: 0)),
              //     );
              //   },
              //   child: Text('Bot Details'),
              // ),
            ],
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Obx(() => ListView.builder(
              controller: scrollController,
              itemCount: controller.botList.length,
              itemBuilder: (context, index) {
                return BotListItem(bot: controller.botList[index]);
              },
            )),
          ),
        ],
      ),
    );
  }
}