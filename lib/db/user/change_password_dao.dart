import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordDao extends ManageUserDAO{
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<String> changePassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
      await _db
          .collection("Users")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({'password': newPassword});
      return "Updated password successfully";
    } catch (error) {
      return "Password update failed";
    }
  }
}
