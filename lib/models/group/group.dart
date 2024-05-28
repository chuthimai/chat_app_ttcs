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

  Member get leader => _leader!;

  String get idConversation => _idConversation;

  set leader(Member value) {
    _leader = value;
  }

  List<Member> get allMember => _allMember;

  set allMember(List<Member> value) {
    _allMember = value;
    _numOfMem = _allMember.length;
  }

  String get nameGroup => _nameGroup;

  set nameGroup(String value) {
    _nameGroup = value;
  }

  int get numOfMem => _numOfMem!;
}