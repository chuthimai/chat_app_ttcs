import 'package:chat_app_ttcs/screens/user/start_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFrm extends StatefulWidget {
  const ForgotPasswordFrm({super.key});

  @override
  State createState() {
    return _ForgotPasswordFrmState();
  }
}

class _ForgotPasswordFrmState extends State<ForgotPasswordFrm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _switchLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (cxt) => const StartScreen(titleAppBar: "Login")));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Forgot Password Form",
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
                child: const Text("Send"),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _switchLogin(context);
                },
                style: ElevatedButton.styleFrom(),
                child: const Text("Login"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
