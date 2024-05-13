import 'package:chat_app_ttcs/forms/user/forgot_password.dart';
import 'package:chat_app_ttcs/forms/user/login.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final String titleAppBar;

  const StartScreen({super.key, required this.titleAppBar});

  @override
  Widget build(BuildContext context) {
    Widget form = titleAppBar=="Login" ? const LoginFrm() : const ForgotPasswordFrm();
    var size = MediaQuery.of(context).size.width;
    double marginHor = 70;
    if (size < 469) marginHor = 70 - (469 - size)/2;
    if (marginHor < 0) marginHor = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: marginHor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: form,
            ),
          ),
        ),
      ),
    );
  }
}
