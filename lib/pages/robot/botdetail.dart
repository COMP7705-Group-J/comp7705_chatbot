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
                  Text(
                    'Bot Name: ${_botDetails.chatbot_name}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  if (_botDetails.chatbot_type == 1)
                    Text(
                      'Bot Persona: ${_botDetails.chatbot_persona}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _deleteBot,
                    child: Text('Delete Bot'),
                  ),
                ],
              ),
            ),
    );
  }
}