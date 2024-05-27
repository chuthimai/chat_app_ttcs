import 'package:chat_app_ttcs/models/group/member.dart';

class Group {
  final String _idConversation;
  String _nameGroup;
  List<Member> _allMember;
  Member? _leader;
  int? _numOfMem;

  Group(this._idConversation, this._nameGroup, this._allMember) {
    _leader = _allMember.where((element) => element.roleInGroup == "Leader").first;
    _numOfMem = _allMember.length;
  }
}