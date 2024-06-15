import 'package:comp7705_chatbot/controller/UserDataController.dart';
import 'package:comp7705_chatbot/pages/home_page.dart';
import 'package:comp7705_chatbot/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../components/already_have_an_account_acheck.dart';
import 'package:comp7705_chatbot/const.dart';
import '../../Signup/signup_screen.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final userDataController = UserDataController();
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  bool _isObscure = true;
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;
  //final _authService = AuthService();

  Future<void> _onLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Perform login logic with _username and _password
      try {
        final loginRes = await AuthService.login(_username!, _password!);
        int userId = loginRes['user_id'];
        String accessToken = loginRes['access'];
        //存储userId和token
        await UserDataController.saveUserId(userId);
        await UserDataController.saveToken(accessToken);
        print('Login: $userId');
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
          const SizedBox(height: defaultPadding/2),
          Row(
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value!;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsOfServicePage()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'I have read and agree to the ',style: TextStyle(color: Colors.black), ),
                          TextSpan(
                            text: '"Terms & Conditions"',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding/2),
            Row(
              children: [
                Checkbox(
                  value: _agreedToPrivacy,
                  onChanged: (value) {
                    setState(() {
                      _agreedToPrivacy = value!;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: 'I have read and agree to the ',style: TextStyle(color: Colors.black),),
                          TextSpan(
                            text: '"Privacy Policy"',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: defaultPadding/2),
          ElevatedButton(
            onPressed: _agreedToTerms && _agreedToPrivacy ? _onLogin : null,
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
Future<String> _loadTermsOfServiceFromAsset() async {
    return await rootBundle.loadString('assets/markdown/terms_and_conditions.md');
  }

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: FutureBuilder<String>(
        future: _loadTermsOfServiceFromAsset(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
            // return Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Terms of Service',
            //         style: TextStyle(
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.blue,
            //         ),
            //       ),
            //       SizedBox(height: 16.0),
            //       Expanded(
            //         child: SingleChildScrollView(
            //           child: Text(snapshot.data!),
            //         ),
            //       ),
            //     ],
            //   ),
            //);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading Terms of Service'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
Future<String> _loadPrivacyPolicyFromAsset() async {
    return await rootBundle.loadString('assets/markdown/privacy_policy.md');
  }

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
       body: FutureBuilder<String>(
        future: _loadPrivacyPolicyFromAsset(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
            // return Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Terms of Service',
            //         style: TextStyle(
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.blue,
            //         ),
            //       ),
            //       SizedBox(height: 16.0),
            //       Expanded(
            //         child: SingleChildScrollView(
            //           child: Text(snapshot.data!),
            //         ),
            //       ),
            //     ],
            //   ),
            //);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading Privacy Policy'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}