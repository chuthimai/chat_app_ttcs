import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _enterOldPassword = '';
  String _enterNewPassword = '';
  String _enterConfirmNewPassword = '';
  final ChangePasswordDao _changePasswordDAO = ChangePasswordDao();
  late UserData user;

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  void _getCurrentUser() async {
    user = await _changePasswordDAO.getCurrentUser();
  }

  void _clickChangePassword() async{
    var isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();

    await _changePasswordDAO.changePassword(_enterNewPassword);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Changed password successfully"),
      ),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }

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
                key: _formKey,
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
                      onSaved: (value) {
                        _enterOldPassword = value!;
                      },
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Please enter your old password at least 6 characters.";
                        }
                        if (value != user.password) {
                          return "Your old password does not correct.";
                        }
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
                      onChanged: (value) {
                        _enterNewPassword = value;
                      },
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Please enter your old password at least 6 characters.";
                        }
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
                      onSaved: (value) {
                        _enterConfirmNewPassword = value!;
                      },
                      validator: (value) {
                        if (_enterNewPassword != value) {
                          return "Confirm the password is different from the new password.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _clickChangePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(213, 246, 189, 208),
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
