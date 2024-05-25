import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:get/get.dart';

class BotController extends GetxController {
  var botList = <Bot>[].obs;

  static BotController get to => Get.find();


  void getBotList(String userId) async {
    print('[BotController getBotList]');
    botList.value = await BotRepository().getBotList(userId);
    update();
  }

  

}