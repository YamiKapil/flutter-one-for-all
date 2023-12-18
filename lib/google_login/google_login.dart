import 'package:flutter/material.dart';
import 'package:one_for_all/google_login/login_api.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Login'),
      ),
      body: ElevatedButton(
        onPressed: () async {
          var user = await LoginApi.login();
          if (user != null) {
            print('hehehe');
            print(user.displayName);
            print(user.email);
          }
        },
        child: const Text('Login with Google'),
      ),
    );
  }
}
