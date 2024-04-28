import 'package:chat_app_ttcs/models/user/user.dart';

class UserSeclected extends User {
  bool isSelected = false;

  void setSelected(bool value) {
    isSelected = !value;
  }

  UserSeclected({
    required super.fullName,
    required super.phoneNum,
    required super.userEmail,
    required super.password,
    required super.role,
  });


}
