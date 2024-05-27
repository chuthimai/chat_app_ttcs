import 'package:chat_app_ttcs/models/attending_conversation.dart';
import 'package:chat_app_ttcs/models/conversation.dart';
import 'package:chat_app_ttcs/models/group/group.dart';
import 'package:chat_app_ttcs/models/group/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ManageGroupDAO {
  final _db = FirebaseFirestore.instance;
  final _uuid = const Uuid();

  void createGroup({required String nameConversation, required List<Member> allMember}) async {
    final String idConversation = uuid.v4();
    await _db.collection('Conversation').doc(idConversation).set(
      {'id': idConversation, 'nameConversation': nameConversation},
      SetOptions(merge: true),
    );

    allMember.toList().forEach((member) async {
      AttendingConversation attend = AttendingConversation(member.idUser, idConversation);
      attend.conversationRole = member.roleInGroup;
      await _db.collection('AttendingConversation').add(attend.toMap());
    });
  }

  // Future<List<Group>> getAllGroup() async {
  //   final conversations = await _db.collection('Conversation').get().then(
  //           (value) =>
  //           value.docs.map((e) => Conversation.toConversation(e.data())));
  //
  //   return conversations.toList() ?? [];
  // }
}
