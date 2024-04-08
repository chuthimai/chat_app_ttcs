import 'package:chat_app_ttcs/forms/user/forgot_password.dart';
import 'package:chat_app_ttcs/forms/user/login.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loggin"),
      ),
      body: const Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 70),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              child: ForgotPasswordFrm(),
            ),
          ),
        ),
      ),
    );
  }
}
