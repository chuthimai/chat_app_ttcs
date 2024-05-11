import 'dart:io';
import 'package:chat_app_ttcs/db/staff/manage_conversation_dao.dart';
import 'package:chat_app_ttcs/models/attending_conversation.dart';
import 'package:chat_app_ttcs/models/conversation.dart';
import 'package:chat_app_ttcs/screens/staff/detail_conversation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllConversations extends StatefulWidget {
  const AllConversations({super.key});

  @override
  State<AllConversations> createState() => _AllConversationsState();
}

class _AllConversationsState extends State<AllConversations> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _manageConversation = ManageConversationDAO();
  List<Conversation>? _allConversation;
  List<AttendingConversation>? _allAttendingConversation;
  List<Map<String, String>>? _nameAllConversation;

  @override
  void initState() {
    _getAllConversation();
    _getAllAttendingConversation();
    _mapConversation();
    super.initState();
  }

  Future<void> _getAllConversation() async {
    final conversation = await _manageConversation.getAllConversation();
    setState(() {
      _allConversation = conversation.toList();
    });
  }

  Future<void> _getAllAttendingConversation() async {
    final attCon =
        await _manageConversation.getAllAttendingConversationOfUser();
    setState(() {
      _allAttendingConversation = attCon.toList();
    });
  }

  Future<void> _mapConversation() async {
    await _getAllConversation();
    await _getAllAttendingConversation();
    final nameAllConDoc = _allAttendingConversation!.map((e) async {
      final conversation = _allConversation!
          .where((element) => element.idConversation == e.idConversation)
          .first;
      if (conversation.nameConversation != 'default') {
        return {
          'id': conversation.idConversation,
          'nameConversation': conversation.nameConversation,
          'subtitle': '',
          'avatar': '',
        };
      }
      final users = await _manageConversation
          .getAllMemberOfConversation(conversation.idConversation);
      final user = users
          .where((element) => element.idUser != _firebaseAuth.currentUser!.uid)
          .first;
      return {
        'id': conversation.idConversation,
        'nameConversation': user.fullName,
        'subtitle': user.companyEmail,
        'avatar': user.avatar,
      };
    }).toList();
    final nameAllCon = await Future.wait(nameAllConDoc);
    setState(() {
      _nameAllConversation = nameAllCon.toList() ?? [];
    });
  }

  void _selectConversation(
      BuildContext context, Map<String, String> conversationInfo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailConversationScreen(
          idConversation: conversationInfo['id']!,
          nameConversation: conversationInfo['nameConversation']!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_nameAllConversation == null) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (_nameAllConversation!.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("No conversation found."),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ..._nameAllConversation!.map((conversation) {
            return ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(conversation['avatar']!),
              ),
              title: Text(
                conversation['nameConversation']!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                conversation['subtitle']!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              onTap: () {
                _selectConversation(context, conversation);
              },
            );
          }),
        ],
      ),
    );
  }
}
