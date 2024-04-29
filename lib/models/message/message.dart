class Message {
  final int _idMessage;
  final int _idConversation;
  final String _idUserSend;
  final DateTime _timeSend = DateTime.now();

  Message(this._idMessage, this._idConversation, this._idUserSend);

  DateTime get timeSend => _timeSend;

  String get idUserSend => _idUserSend;

  int get idConversation => _idConversation;

  int get idMessage => _idMessage;
}