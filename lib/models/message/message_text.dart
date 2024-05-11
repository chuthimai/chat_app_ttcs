import 'package:chat_app_ttcs/models/data_obj.dart';
import 'package:chat_app_ttcs/models/message/message.dart';

class MessageText extends Message implements DataObj {
  final String _contentMessage;

  MessageText(
    super.idConversation,
    super.idUserSend,
    this._contentMessage,
  );

  String get contentMessage => _contentMessage;

  @override
  toMap() {
    return {
      'id': idMessage,
      'idConversation': idConversation,
      'idUserSend': idUserSend,
      'contentMessage': _contentMessage,
      'timeSend': timeSend,
      'isText': true,
      'isImage': false,
      'isVoice': false,
    };
  }

  factory MessageText.toMessageText(Map<String, dynamic> json) {
    final message =  MessageText(
      json['idConversation'],
      json['idUserSend'],
      json['contentMessage'],
    );
    message.idMessage = json['id'];
    message.timeSend = json['timeSend'];
    return message;
  }
}
