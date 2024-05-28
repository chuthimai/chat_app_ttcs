import 'package:chat_app_ttcs/models/attending_conversation.dart';
import 'package:chat_app_ttcs/models/conversation.dart';
import 'package:chat_app_ttcs/models/group/group.dart';
import 'package:chat_app_ttcs/models/group/member.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ManageGroupDAO {
  final _db = FirebaseFirestore.instance;
  final _uuid = const Uuid();
  List<Conversation> _allGroupCon = [];
  List<AttendingConversation> _allAttendGroupCon = [];
  List<UserData> _allUsers = [];

  Future<void> _getAllGroupCon() async {
    final allGroupCon = await _db
        .collection("Conversation")
        .where('nameConversation', isNotEqualTo: 'default')
        .get()
        .then((value) =>
            value.docs.map((e) => Conversation.toConversation(e.data())));
    _allGroupCon = allGroupCon.toList();
  }

  Future<void> _getAllAttendGroupCon() async {
    final allAttendGroupCon = await _db
        .collection('AttendingConversation')
        .where('conversationRole', isNotEqualTo: 'friend')
        .get()
        .then((value) => value.docs.map(
            (e) => AttendingConversation.toAttendingConversation(e.data())));

    _allAttendGroupCon = allAttendGroupCon.toList();
  }

  Future<void> _getAllUsers() async {
    final allUsers = await _db
        .collection('Users')
        .get()
        .then((value) => value.docs.map((e) => UserData.toUser(e.data())));

    _allUsers = allUsers.toList();
  }

  void createGroup(
      {required String nameConversation,
      required List<Member> allMember}) async {
    final String idConversation = _uuid.v4();
    await _db.collection('Conversation').doc(idConversation).set(
      {'id': idConversation, 'nameConversation': nameConversation},
      SetOptions(merge: true),
    );

    allMember.toList().forEach((member) async {
      AttendingConversation attend =
          AttendingConversation(member.idUser, idConversation);
      attend.conversationRole = member.roleInGroup;
      await _db.collection('AttendingConversation').add(attend.toMap());
    });
  }

  Group getGroup({required String idConversation}) {
    // them conversation
    final conversation = _allGroupCon
        .firstWhere((element) => element.idConversation == idConversation);
    final attendCon = _allAttendGroupCon
        .where((element) => element.idConversation == idConversation);

    // them attending conversation
    final allMember = attendCon.map((e) {
      final user =
          _allUsers.firstWhere((element) => element.idUser == e.idUser);
      final member =
          Member(user.idUser, user.fullName, user.gender, user.companyEmail);
      member.roleInGroup = e.conversationRole;
      return member;
    }).toList();

    final group =
        Group(idConversation, conversation.nameConversation, allMember);
    return group;
  }

  Future<List<Group>> getAllGroup() async {
    await _getAllGroupCon();
    await _getAllAttendGroupCon();
    await _getAllUsers();
    final groups =  _allGroupCon.map((e) => getGroup(idConversation: e.idConversation));
    return groups.toList();
  }
}
