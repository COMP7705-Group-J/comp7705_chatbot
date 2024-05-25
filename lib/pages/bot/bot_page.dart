import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/controller/BotController.dart';
import 'package:get/get.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comp7705_chatbot/pages/bot/bot_detail.dart';
class BotPage extends StatefulWidget {
  const BotPage({super.key});

  @override
  State<BotPage> createState() => _BotPageState();
}

class BotListItem extends StatelessWidget {
  final Bot bot;

  BotListItem({required this.bot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(
        FontAwesomeIcons.robot, // 使用Flutter内置的账号图标作为头像
        color: Colors.grey,
        size: 26, // 设置图标大小
        )
      ),
      title: Text(bot.chatbot_name),
      // subtitle: Text(
      //   '${bot.content}\n${bot.timestamp.toLocal().toString().split(' ')[0]}',
      //   maxLines: 2,
      //   overflow: TextOverflow.ellipsis,
      // ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BotDetail(botId: bot.chatbot_id.toString()),
          ),
        );
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
      appBar: AppBar(title: Text('Bot List')),
      body: Obx(() =>ListView.builder(
        controller: scrollController,
        itemCount: controller.botList.length,
        itemBuilder: (context, index) {
          return BotListItem(bot: controller.botList[index]);
        },
      )),
    );
  }
}