import 'dart:io';

import 'package:chat_app_ttcs/models/department.dart';
import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user_auth.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ManageUserDAO {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance
      .ref()
      .child('avatar')
      .child('${FirebaseAuth.instance.currentUser!.uid}.png');

  Future<List<UserData>> getAllUsersOn() async {
    final users = await _db.collection('Users').get().then((value) {
      return value.docs.map((e) {
        return UserData.toUser(e.data());
      }).where((element) => element.state);
    });

    return users.toList();
  }

  Future<List<UserData>> getAllUsers() async {
    final users = await _db.collection('Users').get().then((value) {
      return value.docs.map((e) {
        return UserData.toUser(e.data());
      });
    });

    return users.toList();
  }

  Future<List<UserData>> getAllNormalUsers() async {
    final users = await getAllUsersOn();
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
    await updateUser(user); // code giong voi updateUser
  }

  Future<void> updateUser(UserData user) async {
    await _db
        .collection('Users')
        .doc(user.idUser)
        .set(user.toMap(), SetOptions(merge: true));
  }

  Future<void> deleteUser(UserData user) async {
    await _db
        .collection("Users")
        .doc(user.idUser)
        .set({'state': false}, SetOptions(merge: true));

    final admin = await getCurrentUser();

    await _firebaseAuth.signInWithEmailAndPassword(email: user.companyEmail, password: user.password);
    await _firebaseAuth.currentUser!.delete();

    await _firebaseAuth.signInWithEmailAndPassword(email: admin.companyEmail, password: admin.password);
  }

  void saveAvatarImage(File file) async {
    await _firebaseStorage.putFile(file);
    final imageURL = await _firebaseStorage.getDownloadURL();
    await _db
        .collection('Users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({'avatar': imageURL});
  }

  Future<Position> getPosition(String idJobTransfer) async {
    final jobTransferDoc =
    await _db.collection('JobTransfer').doc(idJobTransfer).get();
    final jobTransfer = JobTransfer.toJobTransfer(jobTransferDoc.data()!);

    final positionDoc = await _db
        .collection('Position')
        .doc(jobTransfer.idNewPosition.toString())
        .get();
    final position = Position.toPosition(positionDoc.data()!);

    final departmentDoc = await positionDoc.data()!['department'].get();
    final department = Department.toDepartment(departmentDoc.data()!);

    position.department = department;
    return position;
  }
}
