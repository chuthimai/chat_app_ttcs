import 'package:chat_app_ttcs/screens/admin/all_groups_screen.dart';
import 'package:chat_app_ttcs/screens/admin/all_users_screen.dart';
import 'package:chat_app_ttcs/screens/user/change_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  Widget _form = const AllUsersScreen();

  void _selectChangePassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ChangePasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.admin_panel_settings,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          "Admin",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.supervised_user_circle,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  "All Users",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22,
                      ),
                ),
                onTap: () {
                  setState(() {
                    _form = const AllUsersScreen();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group_work,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  "All Groups",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22,
                      ),
                ),
                onTap: () {
                  setState(() {
                    _form = const AllGroupScreen();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.password,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22,
                      ),
                ),
                onTap: () {
                  _selectChangePassword(context);
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  })
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Container(alignment: Alignment.topCenter, child: _form),
      ),
    );
  }
}
