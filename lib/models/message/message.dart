int idMessageControl = 1;

class Message {
  final int _idMessage = idMessageControl++;
  final int idConversation;
  final int idUserSend;
  final DateTime timeSend = DateTime.now();

  Message({required this.idConversation, required this.idUserSend});
}