import 'dart:io';

import 'package:chat_app_ttcs/screens/staff/detail_conversation_screen.dart';
import 'package:flutter/material.dart';

class AllConversations extends StatefulWidget {
  const AllConversations({super.key});

  @override
  State<AllConversations> createState() => _AllConversationsState();
}

class _AllConversationsState extends State<AllConversations> {
  void _selectConversation(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailConversationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (ctx, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              foregroundImage:
                  FileImage(File("assets/images/avatar_default.png")),
            ),
            title: Text("Conversation A", style: Theme.of(context).textTheme.titleMedium,),
            onTap: () {
              _selectConversation(context);
            },
          );
        },
      ),
    );
  }
}
