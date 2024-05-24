import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:comp7705_chatbot/service/auth_service.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../Login/login_screen.dart';
import 'package:comp7705_chatbot/const.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;

  bool _isLoading = false;


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSaved() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform sign-up logic with the values from the controllers
      String username = _usernameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();
      // Do something with the collected data
    }
  }
  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        await AuthService.register(
          _usernameController.text,
          _passwordController.text,
          _emailController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
            duration: Duration(seconds: 2),
          ),
        );
        // 注册成功后的处理逻辑
        // 例如: 跳转到登录页面或显示成功提示
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } catch (e) {
        // 注册失败的错误处理
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: $e'),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
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
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: mainColor,
              validator: (value) => value?.isEmpty ?? true ? 'Please enter a username' : null,
              decoration: const InputDecoration(
                hintText: "Your username",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: mainColor,
              //validator: (value) => value?.isEmpty ?? true ? 'Please enter an email' : null,
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              obscureText: _isObscure,
              cursorColor: mainColor,
              //validator: (value) => value?.isEmpty ?? true ? 'Please enter a password' : null,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a password';
                } else if (value!.length < 8) {
                  return 'Password must be at least 8 characters long';
                } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                    .hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
                }
                return null;
              },
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
              controller: _confirmPasswordController,
              textInputAction: TextInputAction.done,
              obscureText: _isObscure,
              cursorColor: mainColor,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please confirm your password';
                }
                if (_passwordController.text != value) {
                  return 'Passwords do not match';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Confirm your password",
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ElevatedButton(
              onPressed: _handleRegister,
              child: Text("Sign Up".toUpperCase()),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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