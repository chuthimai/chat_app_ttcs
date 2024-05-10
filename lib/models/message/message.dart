import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Message{
  String _idMessage = uuid.v8();
  final String _idConversation;
  final String _idUserSend;
  Timestamp _timeSend = Timestamp.now();

  Message(this._idConversation, this._idUserSend);

  set idMessage(String value) {
    _idMessage = value;
  }

  set timeSend(Timestamp value) {
    _timeSend = value;
  }

  Timestamp get timeSend => _timeSend;

  String get idUserSend => _idUserSend;

  String get idConversation => _idConversation;

  String get idMessage => _idMessage;
}