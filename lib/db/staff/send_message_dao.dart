import 'package:chat_app_ttcs/models/message/message_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessageDAO {
  final _db = FirebaseFirestore.instance;

  Future<void> sendMessageText(MessageText messageText) async {
    await _db
        .collection("Message")
        .doc(messageText.idMessage)
        .set(messageText.toMap(), SetOptions(merge: true));
  }
}
