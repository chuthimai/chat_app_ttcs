class AttendingConversation {
  final int _idUser;
  final int _idConversation;
  String _conversationRole;

  AttendingConversation(
    this._idUser,
    this._idConversation,
    this._conversationRole,
  );

  String get conversationRole => _conversationRole;

  int get idConversation => _idConversation;

  int get idUser => _idUser;
}
