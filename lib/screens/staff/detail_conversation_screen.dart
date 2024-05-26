import 'package:chat_app_ttcs/forms/staff/chat_messages.dart';
import 'package:chat_app_ttcs/forms/staff/new_message.dart';
import 'package:chat_app_ttcs/screens/leader/info_group_screen.dart';
import 'package:chat_app_ttcs/screens/staff/other_info_screen.dart';
import 'package:flutter/material.dart';

class DetailConversationScreen extends StatelessWidget {
  final String idConversation;
  final String nameConversation;
  final bool isGroup;

  const DetailConversationScreen({
    super.key,
    required this.idConversation,
    required this.nameConversation,
    required this.isGroup,
  });

  void _selectInfo(BuildContext context) {
    if (isGroup) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const InfoGroupScreen(),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => OtherInfoScreen(
          idConversation: idConversation,
        ),
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
            Expanded(
                child: ChatMessages(
              idConversation: idConversation,
            )),
            NewMessage(
              idConversation: idConversation,
            ),
          ],
        ),
      ),
    );
  }
}
