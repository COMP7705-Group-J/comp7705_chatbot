import 'package:comp7705_chatbot/pages/sign_regi_welc/Screens/Welcome/welcome_screen.dart';
import 'package:comp7705_chatbot/pages/sign_regi_welc/Screens/change_pw/change_pw_screen';
import 'package:flutter/material.dart';
import '../sign_regi_welc/components/background.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String email;

  const ProfilePage({super.key, required this.username,required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedAvatarAsset = 'assets/icons/girl1.png'; // 默认头像

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showAvatarSelectionDialog();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(selectedAvatarAsset),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '${widget.username}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('${widget.email}'),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            _buildListItem(
              icon: Icons.person_outline,
              title: 'Account',
              onTap: () {
                // Navigate to account settings
              },
            ),
            _buildListItem(
              icon: Icons.settings_outlined,
              title: 'Change Password',
              onTap: () {
                // Navigate to app settings
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangePasswordScreen();
                    },
                  ),
                );
              },
            ),
            _buildListItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                // Navigate to about page
              },
            ),
            _buildListItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                // Implement logout functionality
                // 跳转到welcome
                bool confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            // 关闭弹窗
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            // 关闭弹窗并跳转到welcome页面
                            Navigator.of(context).pop(true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const WelcomeScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
                // 如果用户确认退出
                if (confirm) {
                  // 实现退出功能
                  // ...
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAvatarSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Avatar'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAvatarOption('assets/icons/girl1.png'),
                    _buildAvatarOption('assets/icons/girl2.png'),
                    _buildAvatarOption('assets/icons/girl3.png'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAvatarOption('assets/icons/boy1.png'),
                    _buildAvatarOption('assets/icons/boy2.png'),
                    _buildAvatarOption('assets/icons/boy3.png'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarOption(String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAvatarAsset = assetPath;
        });
        Navigator.of(context).pop();
      },
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(assetPath),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 16.0),
            Expanded(child: Text(title)),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}