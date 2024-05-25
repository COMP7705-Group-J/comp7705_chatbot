import 'package:comp7705_chatbot/pages/robot/robot_page.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:comp7705_chatbot/service/bot_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateBotPageUI extends StatefulWidget {
  const CreateBotPageUI({Key? key}) : super(key: key);

  @override
  _CreateBotPageUIState createState() => _CreateBotPageUIState();
}

class _CreateBotPageUIState extends State<CreateBotPageUI> {
  final _formKey = GlobalKey<FormState>();
  String _botName = '';
  int _botType = 0; // Default bot type
  String _botPersona = '';
  BotRepository repository = BotRepository();

  Future<void> _createBot() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      try {
        final userId = 1; // Replace with the actual user ID
        Bot botReq = Bot(
          user_id:userId,
          chatbot_name:_botName,
          chatbot_type:_botType,
          chatbot_persona:_botPersona,
        );
        print('creatqqqebotresponse');
        final createbotresponse = await repository.createBot(botReq);
        // Process the bot details as needed
        print('createbotresponse');
        print(createbotresponse);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Create Bot successful!'),
            duration: Duration(seconds: 2),
          ),
        );
        // 注册成功后的处理逻辑
        // 例如: 跳转到登录页面或显示成功提示
        Navigator.push(context, MaterialPageRoute(builder: (context) => RobotPage()));
      } catch (e) {
        // Handle any exceptions, such as HttpException
        print('Error creating bot: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Bot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            const CircleAvatar(
              radius: 50,
              child:Center(
              child: Icon(FontAwesomeIcons.robot, size: 50),
              )
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Bot Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a bot name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _botName = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Bot Type',
                      border: OutlineInputBorder(),
                    ),
                    value: _botType,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Default')),
                      DropdownMenuItem(value: 1, child: Text('persona bot')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _botType = value ?? 1;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_botType == 1)
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Bot Persona',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        _botPersona = value ?? '';
                      },
                    ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _createBot,
                    child: const Text('Create Bot'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

