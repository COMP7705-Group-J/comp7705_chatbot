import 'package:comp7705_chatbot/pages/home_page.dart';
import 'package:comp7705_chatbot/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import 'package:comp7705_chatbot/const.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  bool _isObscure = true;
  //final _authService = AuthService();

  Future<void> _onLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Perform login logic with _username and _password
      try {
        final tokens = await AuthService.login(_username!, _password!);
        // 登录成功后，导航到主页面
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage(username: _username!);
            },
          ),
        );
      } catch (e) {
        // 处理登录失败的情况
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: mainColor,
              onSaved: (username) => _username = username,
              validator: (value) => value?.isEmpty ?? true ? 'Please enter a username/email' : null,
              decoration: const InputDecoration(
                hintText: "Your username/email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: _isObscure,
              cursorColor: mainColor,
              onSaved: (password) => _password = password,
              validator: (value) => value?.isEmpty ?? true ? 'Please enter a password' : null,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: _onLogin,
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}