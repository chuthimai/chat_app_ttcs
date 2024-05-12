import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/screens/user/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginFrm extends StatefulWidget {
  const LoginFrm({super.key});

  @override
  State<LoginFrm> createState() {
    return _LoginFrmState();
  }
}

class _LoginFrmState extends State<LoginFrm> {
  final _firebase = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPassword = '';

  void _clickLogin() async {
    final isValid = _formKey.currentState!.validate(); // KQ chay xac thuc

    if (!isValid) return;

    _formKey.currentState!.save(); // thuc hien hanh dong onSave cua Form

    try {
      final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
      print(userCredentials);
    } on FirebaseAuthException catch (error) {
      // on xu ly 1 ngoai le cu the
      print(error);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content:
              Text(error.message ?? 'Your email or password is incorrect.'),
        ),
      );
    }
  }


  void _switchForgotPassword(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (cxt) => const StartScreen(titleAppBar: "Forgot Password")));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
            onSaved: (value) {
              _enteredEmail = value!;
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
          TextFormField(
            maxLength: 50,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _enteredPassword = value!;
            },
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return "Password must be at least 6 characters long.";
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
                onPressed: _clickLogin,
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
