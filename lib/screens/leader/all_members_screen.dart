import 'dart:io';

import 'package:flutter/material.dart';

class AllMembersScreen extends StatelessWidget {
  AllMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Members"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 26,
                foregroundImage:
                    FileImage(File("assets/images/avatar_default.png")),
              ),
              title: Text(
                "Name",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "Leader",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                // _selectConversation(context);
              },
            );
          },
        ),
      ),
    );
  }
}
