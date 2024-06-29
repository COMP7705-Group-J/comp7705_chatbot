import 'package:comp7705_chatbot/pages/chat/chat_detail.dart';
import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/service/bot_service.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';

class BotDetailsScreen extends StatefulWidget {
  final int userId;
  final int botId;

  BotDetailsScreen({
    required this.userId,
    required this.botId,
  });

  @override
  _BotDetailsScreenState createState() => _BotDetailsScreenState();
}

class _BotDetailsScreenState extends State<BotDetailsScreen> {
  late Bot _botDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBotDetails();
  }

  Future<void> _fetchBotDetails() async {
    try {
      _botDetails = await BotsService.getBotDetail(widget.userId, widget.botId);
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> _deleteBot() async {
    try {
      await BotsService.deleteBot(
        userId: widget.userId,
        botId: widget.botId,
      );
      Navigator.of(context).pop();
    } on HttpException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bot Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/icons/bot_blue.png'),

                    ),
                    SizedBox(height: 16),
                    Text(
                      //TODO fix hard code
                      'everlyn-test-1',
                      //'${_botDetails.chatbot_name}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // 文字居中
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8.0),

            // Text(
            //   'Bot Persona: Friendly', // 'Bot Persona: ${_botDetails.chatbot_persona}',
            //   style: TextStyle(fontSize: 16.0),
            //   textAlign: TextAlign.left, // 文本靠左
            // ),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'Bot Persona: ',
            //         style: TextStyle(fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //
            //       ),
            //       TextSpan(
            //         //TODO fix hard code
            //       text: 'Friendly',
            //         style: TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.deepPurple,
            //         ),
            //       ),
            //       TextSpan(
            //         //TODO fix hard code
            //         text: '  Patient',
            //         style: TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.deepPurple,
            //         ),
            //       ),
            //     ],
            //
            //   ),
            //
            // ),
            SizedBox(height: 12.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Bot Type: ',
                    style: TextStyle(fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                  ),
                  TextSpan(
                    //TODO fix hard code
                    text: 'Default Bot',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Created At: ',
                    style: TextStyle(fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                  ),
                  TextSpan(
                    //TODO fix hard code
                    text: '2024-06-16 14:00',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _deleteBot,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        //side: BorderSide(color: mainColor, width: 2.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text('Delete Chatbot'),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ChatDetail(userId: '1',
                                botId: '10277',
                                botName: 'Olu')),
                      );
                      //       ChatDetail(userId: _botDetails.user_id.toString(),
                      //           botId: _botDetails.user_id.toString(),
                      //           botName: _botDetails.chatbot_name ?? '')),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),//
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text('Chat With Bot'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Bot Details'),
  //     ),
  //     body: _isLoading
  //         ? Center(child: CircularProgressIndicator())
  //         : Padding(
  //             padding: EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Bot Name: ${_botDetails.chatbot_name}',
  //                   style: TextStyle(
  //                     fontSize: 18.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 SizedBox(height: 8.0),
  //                 if (_botDetails.chatbot_type == 1)
  //                   Text(
  //                     'Bot Persona: ${_botDetails.chatbot_persona}',
  //                     style: TextStyle(fontSize: 16.0),
  //                   ),
  //                 SizedBox(height: 16.0),
  //                 ElevatedButton(
  //                   onPressed: _deleteBot,
  //                   child: Text('Delete Bot'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //   );
  // }
}