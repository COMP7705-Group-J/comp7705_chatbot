import 'package:flutter/material.dart';
import '../sign_regi_welc/components/background.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

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
                  Text('johndoe@example.com'),
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
              title: 'Settings',
              onTap: () {
                // Navigate to app settings
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
              onTap: () {
                // Implement logout functionality
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