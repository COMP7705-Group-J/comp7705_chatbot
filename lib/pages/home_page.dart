import 'package:comp7705_chatbot/components/bottom_nav_bar.dart';
import 'package:comp7705_chatbot/const.dart';
import 'package:comp7705_chatbot/pages/chat_page.dart';
import 'package:comp7705_chatbot/pages/profile_page.dart';
import 'package:comp7705_chatbot/pages/robot_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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

  // pages
  final List<Widget> _pages = [
    // robot page
    const RobotPage(),

    // chat page
    const ChatPage(),

    // profile page
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}