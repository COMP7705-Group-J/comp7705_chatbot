import 'package:comp7705_chatbot/components/bottom_nav_bar.dart';
import 'package:comp7705_chatbot/pages/chat/chat_page.dart';
import 'package:comp7705_chatbot/pages/profile/profile_page.dart';
import 'package:comp7705_chatbot/pages/robot/bot_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String email;

  const HomePage({Key? key, required this.username,  required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
      // pages
    final List<Widget> _pages = [
      // robot page
      const BotPage(),

      // chat page
      const ChatPage(),

      // profile page
      ProfilePage(username: widget.username,email: widget.email,),
    ];
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
