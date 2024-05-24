import 'package:comp7705_chatbot/repository/Message.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final chatList = <Message>[].obs;
  var isLoading = false.obs;
  final currentConversationUuid = "".obs;

  static ConversationController get to => Get.find();


  void getChatList(String userId) async {
      isLoading.value = true;
      chatList.value = await ChatRepository().fetchChatList(userId);
      isLoading.value = false;
      update();
  }

  void setCurrentConversationUuid(String uuid) async {
    currentConversationUuid.value = uuid;
  }


}
