import 'package:chat_app_ttcs/forms/staff/chat_messages.dart';
import 'package:chat_app_ttcs/forms/staff/new_message.dart';
import 'package:chat_app_ttcs/screens/leader/info_group_screen.dart';
import 'package:flutter/material.dart';

class DetailConversationScreen extends StatelessWidget {
  final String idConversation;
  final String nameConversation;

  const DetailConversationScreen({
    super.key,
    required this.idConversation,
    required this.nameConversation,
  });

  void _selectInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const InfoGroupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameConversation),
        actions: [
          IconButton(
            onPressed: () {
              _selectInfo(context);
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: ChatMessages(idConversation: idConversation,)),
            NewMessage(idConversation: idConversation,),
          ],
        ),
      ),
    );
  }
}
