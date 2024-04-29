import 'package:chat_app_ttcs/forms/staff/chat_messages.dart';
import 'package:chat_app_ttcs/forms/staff/new_message.dart';
import 'package:chat_app_ttcs/screens/leader/info_group_screen.dart';
import 'package:flutter/material.dart';

class DetailConversationScreen extends StatelessWidget {
  const DetailConversationScreen({super.key});

  void _selectInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => InfoGroupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name Coversation"),
        actions: [
          IconButton(
            onPressed: () {
              _selectInfo(context);
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
