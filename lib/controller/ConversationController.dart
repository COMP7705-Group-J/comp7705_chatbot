import 'package:comp7705_chatbot/repository/Message.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  final chatList = <Message>[].obs;
  var isLoading = false.obs;
  final currentConversationUuid = "".obs;

  static ConversationController get to => Get.find();
  @override
  void onInit() async {
    try {
      isLoading.value = true;
      chatList.value = await ChatRepository().fetchChatList('1');
      isLoading.value = false;
    } catch (error) {
      print("Error fetching list: $error");
      isLoading.value = false;
    }
    //chatList.value = await ChatRepository().fetchChatList('1');
    super.onInit();
  }

  void setCurrentConversationUuid(String uuid) async {
    currentConversationUuid.value = uuid;
  }


}
