import 'package:chat_app_ttcs/db/staff/manage_conversation_dao.dart';
import 'package:chat_app_ttcs/forms/staff/message_bubble.dart';
import 'package:chat_app_ttcs/models/message/message_text.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  final String idConversation;

  const ChatMessages({super.key, required this.idConversation});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final _manageConversation = ManageConversationDAO();
  final _db = FirebaseFirestore.instance;
  final _idCurrentUser = FirebaseAuth.instance.currentUser!.uid;
  List<UserData> _allMember = [];

  @override
  void initState() {
    _getAllMember();
    super.initState();
  }

  Future<void> _getAllMember() async {
    final allMember = await _manageConversation
        .getAllMemberOfConversation(widget.idConversation);
    setState(() {
      _allMember = allMember.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_allMember.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return StreamBuilder(
        stream: _db
            .collection('Message')
            .where('idConversation', isEqualTo: widget.idConversation)
            .orderBy('timeSend', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (chatSnapshots.hasError) {
            print(chatSnapshots.error);
            return const Center(
              child: Text("Something went wrong..."),
            );
          }

          final loadedMessages = chatSnapshots.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 40,
              left: 13,
              right: 13,
            ),
            reverse: true, // dao nguoc tu duoi len
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {

              //kt tin nhan hien tai va tin nhan tiep theo
              final messageText =
                  MessageText.toMessageText(loadedMessages[index].data());
              final nextMessageText = index + 1 < loadedMessages.length
                  ? MessageText.toMessageText(loadedMessages[index + 1].data())
                  : null;
              final idCurrentUserSendMessage = messageText.idUserSend;
              final idNextUserSendMessage = nextMessageText?.idUserSend;

              // kt tin nhan tiep theo co cung nguoi gui hay ko
              final nextUserIsSame =
                  idCurrentUserSendMessage == idNextUserSendMessage;

              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: messageText.contentMessage,
                  isMe: messageText.idUserSend == _idCurrentUser,
                );
              } else {
                UserData user = _allMember
                    .where(
                        (element) => element.idUser == messageText.idUserSend)
                    .first;
                return MessageBubble.first(
                    userImage: user.avatar,
                    username: user.fullName,
                    message: messageText.contentMessage,
                    isMe: messageText.idUserSend == _idCurrentUser);
              }
            },
          );
        });
  }
}
