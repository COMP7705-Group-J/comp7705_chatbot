import 'package:comp7705_chatbot/controller/UserDataController.dart';
import 'package:comp7705_chatbot/pages/profile/about.dart';
import 'package:comp7705_chatbot/pages/profile/account_page.dart';
import 'package:comp7705_chatbot/pages/sign_regi_welc/Screens/Welcome/welcome_screen.dart';
import 'package:comp7705_chatbot/pages/sign_regi_welc/Screens/change_pw/change_pw_screen.dart';
import 'package:comp7705_chatbot/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../sign_regi_welc/components/background.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String email;

  const ProfilePage({required this.username, required this.email});

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${widget.email}'),
                          GestureDetector(
                            onTap: () {
                              // 展示一个对话框,让用户输入新的电子邮件地址
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String newEmail = widget.email;
                                  return AlertDialog(
                                    title: Text('Edit Email'),
                                    content: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                      ),
                                      //: 'Enter new email',
                                      onChanged: (value) {
                                        newEmail = value;
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // 更新电子邮件地址
                                          setState(() {
                                            //widget.email = newEmail;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Save'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.0),
                _buildListItem(
                  icon: Icons.settings_outlined,
                  title: 'Change Password',
                  onTap: () {
                    // Navigate to app settings
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangePasswordScreen(username: widget.username, email: widget.email);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AboutPage();
                        },
                      ),
                    );
                  },
                ),
            _buildListItem(
              icon: Icons.feedback_outlined,
              title: 'Give Us Feedback',
              onTap: () {
                // Show feedback dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String feedback = '';
                    return AlertDialog(
                      title: Text('Give Us Feedback'),
                      content: TextField(
                        onChanged: (value) {
                          feedback = value;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Enter your feedback here...',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Submit'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Feedback submitted successfully!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // Send the feedback to your backend or handle it in some other way
                            print('Feedback: $feedback');
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
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
                  // Clear all user data
                  await UserDataController.clearData();
                  //AuthService.close();
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