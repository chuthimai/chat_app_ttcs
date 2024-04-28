import 'package:chat_app_ttcs/models/message/message.dart';

class MessageText extends Message {
  String contentMessage;

  MessageText({
    required super.idConversation,
    required super.idUserSend,
    required this.contentMessage,
  });
}
