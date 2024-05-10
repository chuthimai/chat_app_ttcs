import 'package:chat_app_ttcs/models/data_obj.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Conversation implements DataObj{
  String _idConversation = uuid.v4();
  String _nameConversation = 'default';

  Conversation();

  String get nameConversation => _nameConversation;

  String get idConversation => _idConversation;

  set idConversation(String value) {
    _idConversation = value;
  }

  set nameConversation(String value) {
    _nameConversation = value;
  }

  @override
  toMap() {
    return {
      'idConversation': _idConversation,
      'nameConversation': _nameConversation,
    };
  }

  factory Conversation.toConversation(Map<String, dynamic> json) {
    final conversation = Conversation();
    conversation.idConversation = json['id'];
    conversation.nameConversation = json['nameConversation'];
    return conversation;
  }
}
