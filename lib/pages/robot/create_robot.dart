import 'package:comp7705_chatbot/controller/BotController.dart';
import 'package:comp7705_chatbot/pages/robot/bot_page.dart';
import 'package:comp7705_chatbot/pages/robot/robot_page.dart';
import 'package:comp7705_chatbot/repository/Bot.dart';
import 'package:comp7705_chatbot/service/bot_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comp7705_chatbot/controller/UserDataController.dart';
import 'package:get/get.dart';

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
  int _userId = 0;

  Future<void> _getUserId() async {
    int ? userId = await UserDataController.getUserId();
    setState(() {
      _userId = userId ?? 0;
    });
  }


  Future<void> _createBot() async {
    await _getUserId();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      try {
        final userId = _userId; // Replace with the actual user ID
        BotRequest botReq = BotRequest(
          user_id:_userId,
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => BotPage()));
      } catch (e) {
        // Handle any exceptions, such as HttpException
        print('Error creating bot: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final BotController controller = Get.find<BotController>();
    controller.getBotPersona();
    final List<String> personas = controller.botPersonas;
    print("personas");
    print(personas);
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
              child: Icon(Icons.android, size: 50),
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
                      _botType = value ?? 0;
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (_botType == 1)
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Bot Persona',
                      border: OutlineInputBorder(),
                    ),
                    value: personas.contains(_botPersona) ? _botPersona : null,
                    items: personas.toSet().map((persona) =>
                      DropdownMenuItem<String>(
                        value: persona,
                        child: Text(persona),
                      )
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && personas.contains(value)) {
                          _botPersona = value;
                        }
                      });
                    },
                  ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Bot Persona',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   onSaved: (value) {
                    //     _botPersona = value ?? '';
                    //   },
                    // ),
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

