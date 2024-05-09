import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageUserDAO {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<UserData> getCurrentUser() async {
    final user = await _db
        .collection("Users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) => UserData.toUser(value.data()!));
    return user;
  }
}