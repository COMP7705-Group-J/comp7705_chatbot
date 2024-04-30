import 'package:comp7705_chatbot/const.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({
    super.key,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        color: Colors.grey[700],
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: mainColor,
        tabBackgroundColor: mainColorback,
        tabBorderRadius: 24,
        tabActiveBorder: Border.all(color:mainColor),
        tabs: const [
          GButton(
            icon: Icons.android_outlined,
            text: 'My Bots',
          ),
          GButton(
            icon: Icons.forum_outlined,
            text: 'Messages',
          ),
          GButton(
            icon: Icons.account_circle_outlined,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
