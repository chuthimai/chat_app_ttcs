import 'package:chat_app_ttcs/db/staff/send_message_dao.dart';
import 'package:chat_app_ttcs/models/message/message_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String idConversation;

  const NewMessage({super.key, required this.idConversation});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _sendMessage = SendMessageDAO();
  final _messageController = TextEditingController();


  void _clickSend() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage
        .trim()
        .isEmpty) return;

    FocusScope.of(context).unfocus(); // đóng bàn phím đang mở
    _messageController.clear();

    final idUser = FirebaseAuth.instance.currentUser!.uid;
    final newMessageText = MessageText(widget.idConversation, idUser, enteredMessage);
    await _sendMessage.sendMessageText(newMessageText);

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
            color: Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_voice),
            color: Theme.of(context).colorScheme.primary,
          ),
          Expanded(child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: "Send a message..."),
          )),
          IconButton(
            onPressed: _clickSend,
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
