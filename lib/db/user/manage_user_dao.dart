import 'package:chat_app_ttcs/models/user/user_auth.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageUserDAO {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<List<UserData>> getAllUsers() async {
    final users = await _db.collection('Users').get().then((value) {
      return value.docs.map((e) {
        return UserData.toUser(e.data());
      }).where((element) => element.state);
    });

    return users.toList();
  }

  Future<List<UserData>> getAllNormalUsers() async {
    final users = await getAllUsers();
    final normalUsers = users.where((element) => element.role == "Normal User");

    return normalUsers.toList();
  }

  Future<UserData> getCurrentUser() async {
    final user = await _db
        .collection("Users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) => UserData.toUser(value.data()!));
    return user;
  }

  Future<String> createAuthUser(UserAuth user) async {
    final id = await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: user.email, password: user.password)
        .then((value) => value.user!.uid);
    return id;
  }

  Future<void> createUser(UserData user) async {
    await _db
        .collection('Users')
        .doc(user.idUser)
        .set(user.toMap(), SetOptions(merge: true));
  }
}