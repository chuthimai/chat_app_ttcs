import 'package:chat_app_ttcs/models/conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageMessageDAO {
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  void getAllMessage(Conversation conversation) {

  }

  void createNewMessageText() {

  }
}