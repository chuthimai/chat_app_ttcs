int idConversationControl = 1;

class Conversation {
  final int _idConversation = idConversationControl++;
  final String nameConversation;

  Conversation(this.nameConversation);
}