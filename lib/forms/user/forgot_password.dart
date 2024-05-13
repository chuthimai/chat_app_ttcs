import 'package:chat_app_ttcs/db/user/forgot_password_dao.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _enterCompanyEmail = '';

  void _switchLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (cxt) => const StartScreen(titleAppBar: "Login")));
  }

  void _clickSend() async {
    print("===> 0.1 ${_formKey.currentState}");
    final isValid = _formKey.currentState!.validate();
    print("===> 0.2");
    if (!isValid) return;
    print("===> 0.3");
    _formKey.currentState!.save();
    print("===> 0.4");
    final forgotPass = ForgotPasswordDAO();
    print("===> 0.5");
    await forgotPass.sendMessageToEmail(_enterCompanyEmail, context);
    print("===> 0.6");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              hintText: "Email Company",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _enterCompanyEmail = value!;
            },
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@cp.vn')) {
                return 'Please enter a valid email address.';
              }

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
                onPressed: () {
                  _clickSend();
                },
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
