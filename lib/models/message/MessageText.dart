import 'package:chat_app_ttcs/models/message/message.dart';

class MessageText extends Message {
  String _contentMessage;

  MessageText(int idMessage, int idConversation, String idUserSend, this._contentMessage)
      : super(idMessage, idConversation, idUserSend);

  String get contentMessage => _contentMessage;
}
