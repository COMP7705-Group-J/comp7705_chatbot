import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Center(
                  child: Image.asset(
                    'assets/icons/bot_blue.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'eFriend',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'About the App',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Introducing our eFriend - your gateway to the future of conversational AI. This chatbot is powered by advanced language processing, allowing it to engage in genuine, lifelike chats tailored just for you.\n\nPersonalize your chatbot\'s personality, interests, and communication style to fit your needs. Whether you\'re looking for a witty intellectual, a caring confidant, or a playful companion, our chatbot can adapt to become the perfect partner for your daily life.',
                  style: Theme.of(context).textTheme.bodyText2,
                  softWrap: true,
                  maxLines: null,
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Contact Us Email:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 8.0),
                Text(
                  'wyl3356@connect.hku.hk zhonghao@connect.hku.hk u3619538@connect.hku.hk u3619733@connect.hku.hk\nzxjsxs@connect.hku.hk',
                  style: Theme.of(context).textTheme.bodyText2,
                  softWrap: true,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}