import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBRole {
  final _db = FirebaseFirestore.instance;

  Future<String> getRole() async {
    var user = await _db
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((querySnapshot) {
      return querySnapshot.data();
    });
    return user?['role'];
  }
}
