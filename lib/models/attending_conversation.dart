import 'package:chat_app_ttcs/models/data_obj.dart';

class AttendingConversation implements DataObj{
  final String _idUser;
  final String _idConversation;
  String _conversationRole = 'friend';
  bool _state = true;

  set conversationRole(String value) {
    _conversationRole = value;
  }

  set state(bool value) {
    _state = value;
  }

  AttendingConversation(
    this._idUser,
    this._idConversation,
  );

  String get conversationRole => _conversationRole;

  String get idConversation => _idConversation;

  String get idUser => _idUser;

  @override
  toMap() {
    return {
      'idUser': _idUser,
      'idConversation': _idConversation,
      'conversationRole': _conversationRole,
      'state': _state,
    };
  }

  factory AttendingConversation.toAttendingConversation(Map<String, dynamic> json) {
    final attCon =  AttendingConversation(json['idUser'], json['idConversation']);
    attCon.state = json['state'];
    attCon.conversationRole = json['conversationRole'];
    return attCon;
  }
}
