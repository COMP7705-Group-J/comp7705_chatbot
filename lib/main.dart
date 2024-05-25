
import 'package:comp7705_chatbot/const.dart';
import 'package:comp7705_chatbot/controller/BotController.dart';
import 'package:comp7705_chatbot/controller/MessageController.dart';
import 'package:comp7705_chatbot/pages/home_page.dart';
import 'package:comp7705_chatbot/pages/sign_regi_welc/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comp7705_chatbot/controller/ConversationController.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ConversationController());
    Get.put(MessageController());
    Get.put(BotController());
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'COMP7705 ChatBot',
      theme: ThemeData(
          primaryColor: mainColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: mainColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: mainColorLight,
            iconColor: mainColor,
            prefixIconColor: mainColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
      );
  }
}
