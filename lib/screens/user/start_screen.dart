import 'package:chat_app_ttcs/forms/user/forgot_password.dart';
import 'package:chat_app_ttcs/forms/user/login.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final String titleAppBar;

  const StartScreen({super.key, required this.titleAppBar});

  @override
  Widget build(BuildContext context) {
    Widget form = titleAppBar=="Login" ? const LoginFrm() : const ForgotPasswordFrm();

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              child: form,
            ),
          ),
        ),
      ),
    );
  }
}
