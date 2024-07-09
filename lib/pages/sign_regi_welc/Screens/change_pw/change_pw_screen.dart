import 'package:comp7705_chatbot/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:comp7705_chatbot/controller/UserDataController.dart';
import 'package:comp7705_chatbot/service/auth_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String username;
  final String email;

  const ChangePasswordScreen({super.key, required this.username, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';
  int _userId = 0;
  String _accessToken = '';
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _getUserId();
    _getAccessToken();
  }

  Future<void> _getUserId() async {
    int? userId = await UserDataController.getUserId();
    setState(() {
      _userId = userId ?? 0;
    });
  }

  Future<void> _getAccessToken() async {
    String? accessToken = await UserDataController.getToken();
    setState(() {
      _accessToken = accessToken ?? '';
    });
  }

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      print(_accessToken);
      try {
        final updateResult = await AuthService.updateUser(
          _userId,
          _accessToken,
          widget.username,
          _confirmPassword,
          widget.email,
        );
        print('Update result: $updateResult');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password changed successfully!'),
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(username: widget.username, email: widget.email),
          ),
        );
      } on HttpException catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change password: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Change Password'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Current Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrentPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                ),
              ),
              obscureText: _obscureCurrentPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your current password';
                }
                return null;
              },
              onSaved: (value) {
                _currentPassword = value!;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureNewPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
              ),
              obscureText: _obscureNewPassword,
              validator: (value) {
                print("value: $value");
                if (value == null || value.isEmpty) {
                  return 'Please enter a new password';
                }
                return null;
              },
              onSaved: (value) {
                print("_newPassword: $_newPassword");
                _newPassword = value!;
                // Validate _confirmPassword after updating _newPassword
                _formKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              obscureText: _obscureConfirmPassword,
              validator: (value) {
                print("newvalue: $value");
                if (value == null || value.isEmpty) {
                  return 'Please confirm your new password';
                }
                if (value != _newPassword) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) {
                _confirmPassword = value!;
                print("_confirmPassword: $_confirmPassword");
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null) {
                  _formKey.currentState?.save();
                  if (_formKey.currentState?.validate() ?? false) {
                    _changePassword();
                  }
                }
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    ),
  );
}
}