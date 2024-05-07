import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowUserDAO {
  final _db = FirebaseFirestore.instance.collection('Users');

  ShowUserDAO();

  Future<List<User>> getAllUsers() async{
    final users = await _db.get().then((value) {
      return value.docs.map((e) {
        return User.toUser(e.data());
      });
    });

    return users.toList();
  }
}