class Conversation {
  final int _idConversation;
  final String _nameConversation;

  Conversation(
    this._idConversation,
    this._nameConversation,
  );

  String get nameConversation => _nameConversation;

  int get idConversation => _idConversation;
}
