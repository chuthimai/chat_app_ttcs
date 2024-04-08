import 'package:chat_app_ttcs/screens/user/start_screen.dart';
import 'package:flutter/material.dart';

class LoginFrm extends StatefulWidget {
  const LoginFrm({super.key});

  @override
  State<LoginFrm> createState() {
    return _LoginFrmState();
  }
}

class _LoginFrmState extends State<LoginFrm> {
  // final _form = GlobalKey<FormState>();

  void _switchForgotPassword(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (cxt) => const StartScreen(titleAppBar: "Forgot Password")));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loggin Form",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
          TextFormField(
            maxLength: 50,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {},
            validator: (value) {
              // Kt trong database
              return null;
            },
          ),
          TextFormField(
            maxLength: 50,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {},
            validator: (value) {
              // kt trong database
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                ),
                child: const Text("Login"),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _switchForgotPassword(context);
                },
                style: ElevatedButton.styleFrom(),
                child: const Text("Forgot Password"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
