import 'package:chat_app_ttcs/models/user/user_data.dart';

class CreateConversationKey {
  final UserData user1;
  final UserData user2;
  String? _key;

  CreateConversationKey({required this.user1, required this.user2}) {
    if (user1.idUser.compareTo(user2.idUser) < 0) {
      _key = '${user1.idUser}-${user2.idUser}';
    } else {
      _key = '${user2.idUser}-${user1.idUser}';
    }
  }

  String get key => _key!;
}