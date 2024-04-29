import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {

  ChangePasswordScreen();

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              child: Form(
                // key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Change Password Form",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      maxLength: 50,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Old Password",
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
                    TextFormField(
                      maxLength: 50,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "New Password",
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
                    TextFormField(
                      maxLength: 50,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Confirm New Password",
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
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                      ),
                      child: const Text("Change Password"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}