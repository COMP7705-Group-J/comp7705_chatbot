import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/controller/BotController.dart';
import 'package:get/get.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:comp7705_chatbot/pages/robot/botdetail.dart';
import 'package:comp7705_chatbot/pages/robot/create_robot.dart';
import 'package:comp7705_chatbot/const.dart';
import 'package:comp7705_chatbot/controller/UserDataController.dart';

class BotPage extends StatefulWidget {
  const BotPage({super.key});

  @override
  State<BotPage> createState() => _BotPageState();
}

class BotListItem extends StatelessWidget {
  final Bot bot;
  final String userId;


  BotListItem({required this.bot, required this.userId});


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
      title: Text(bot.chatbot_name ?? ''),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).push(
             MaterialPageRoute(
               builder: (context) => BotDetailsScreen(
                   userId: int.parse(userId),
                   botId: bot.chatbot_id ?? 0),
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
         // return BotListItem(bot: controller.botList[index]);
        },
      ),
    );
  }
}


class _BotPageState extends State<BotPage> {
  final BotController controller = Get.find<BotController>();
  final ScrollController scrollController = ScrollController();
  String _userId = '';

  Future<String> _getUserId() async {
    int ? userId = await UserDataController.getUserId();
    if (userId != 0) {
      setState(() {
        _userId = userId.toString();
      });
    }
    return _userId;
  }

  Future<void> _retrieveAndUseUserId() async {
    await _getUserId();
    controller.getBotList(_userId); // 现在userId已经被正确设置了
  }


  @override
  void initState() {
    super.initState();
    _getUserId();
    _retrieveAndUseUserId();
    //controller.getBotList(_userId);
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Bot List')),
    body: Column(
      children: [
        SizedBox(height: 8.0),
        // 固定在顶部的两个 TextButton,避开状态栏
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // add your button functionality here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateBotPageUI()),
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: mainColor, width: 2.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text('Create Bot'),
                  ),
                ),
                SizedBox(width: 8.0),
                // Expanded(
                //   child: TextButton(
                //     onPressed: () {
                //       // add your button functionality here
                //     },
                //     style: TextButton.styleFrom(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12.0),
                //         side: BorderSide(color: mainColor, width: 2.0),
                //       ),
                //       padding: EdgeInsets.symmetric(vertical: 16.0),
                //     ),
                //     child: Text('New Chat'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        // 可滚动的ListView.builder
        Expanded(
          child: Obx(() => ListView.builder(
            controller: scrollController,
            itemCount: controller.botList.length,
            itemBuilder: (context, index) {
              return BotListItem(bot: controller.botList[index], userId: _userId);
            },
          )),
        ),
      ],
    ),
  );
}
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//      // appBar: AppBar(title: Text('Bot List')),
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(builder: (context) => CreateBotPageUI()),
//               //     );
//               //   },
//               //   child: Text('Create Chatbot'),
//               // ),
//               // SizedBox(width: 16.0),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(builder: (context) => BotDetailsScreen(userId: 0, botId: 0)),
//               //     );
//               //   },
//               //   child: Text('Bot Details'),
//               // ),
//             ],
//           ),
//           SizedBox(height: 16.0),
//           Expanded(
//             child: Obx(() => ListView.builder(
//               controller: scrollController,
//               itemCount: controller.botList.length,
//               itemBuilder: (context, index) {
//                 return BotListItem(bot: controller.botList[index]);
//               },
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }