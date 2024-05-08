
import 'package:chat_app_ttcs/forms/admin/user/new_user_form.dart';
import 'package:flutter/material.dart';

import 'all_groups_screen.dart';
import 'all_users_screen.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  Widget _form = const AllUsersScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.admin_panel_settings,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "Admin",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "maict.b21cn082@stu.ptit.edu.vn",
                        style: Theme.of(context).textTheme.bodySmall,
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
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: NewUserForm(),
      ),
    );
  }
}
