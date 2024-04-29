import 'dart:io';

import 'package:chat_app_ttcs/forms/staff/all_conversations.dart';
import 'package:chat_app_ttcs/screens/user/change_password_screen.dart';
import 'package:flutter/material.dart';

class ViewListFriendScreen extends StatefulWidget {
  const ViewListFriendScreen({super.key});

  @override
  State<ViewListFriendScreen> createState() => _ViewListFriendScreenState();
}

class _ViewListFriendScreenState extends State<ViewListFriendScreen> {
  void _selectChangePassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ChangePasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
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
                        leading: InkWell(
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.black,
                            foregroundImage: FileImage(File("assets/images/avatar_default.png")),
                          ),
                          onDoubleTap: () {},
                        ),
                        title: Text(
                          "Chu Thi Mai",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Text(
                          "maict@cp.vn",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
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
                    //TODO: logout
                  })
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Container(alignment: Alignment.topCenter, child: AllConversations()),
      ),
    );
  }
}
