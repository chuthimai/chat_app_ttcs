import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/forms/staff/create_conversation_key.dart';
import 'package:chat_app_ttcs/models/attending_conversation.dart';
import 'package:chat_app_ttcs/models/conversation.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageConversationDAO extends ManageUserDAO {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<List<AttendingConversation>>
      getAllAttendingConversationOfUser() async {
    try {
      final attendingCon = await _db
          .collection('AttendingConversation')
          .where('idUser', isEqualTo: _firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.map((e) {
          return AttendingConversation.toAttendingConversation(e.data());
        });
      });

      return attendingCon.toList() ?? [];
    } catch (e) {
      print("Error fetching all attending conversations: $e");
      return []; // Trả về một danh sách rỗng trong trường hợp có lỗi
    }
  }

  Future<List<UserData>> getAllMemberOfConversation(
      String idConversation) async {
    final attendingCon = await _db
        .collection('AttendingConversation')
        .where("idConversation", isEqualTo: idConversation)
        .get()
        .then((value) {
      return value.docs.map((e) {
        return AttendingConversation.toAttendingConversation(e.data());
      }).toList();
    });

    List<UserData> allMember = [];
    for (AttendingConversation attendingCon in attendingCon) {
      final memberDoc =
          await _db.collection("Users").doc(attendingCon.idUser).get();
      final member = UserData.toUser(memberDoc.data()!);
      allMember.add(member);
    }

    return allMember;
  }

  Future<List<Conversation>> getAllConversation() async {
    final conversations = await _db.collection('Conversation').get().then(
        (value) =>
            value.docs.map((e) => Conversation.toConversation(e.data())));

    return conversations.toList() ?? [];
  }

  Future<void> createConversationWith2People(
      {required UserData currentUser, required UserData otherUser}) async {

    CreateConversationKey conversationKey =
        CreateConversationKey(user1: currentUser, user2: otherUser);

    await _db.collection('Conversation').doc(conversationKey.key).set(
      {'id': conversationKey.key, 'nameConversation': 'default'},
      SetOptions(merge: true),
    );

    AttendingConversation attend1 =
        AttendingConversation(currentUser.idUser, conversationKey.key);
    AttendingConversation attend2 =
        AttendingConversation(otherUser.idUser, conversationKey.key);

    await _db.collection('AttendingConversation').add(attend1.toMap());
    await _db.collection('AttendingConversation').add(attend2.toMap());
  }

  void addMember(Conversation conversation, UserData member) {}
}
