import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:flutter/material.dart';

class UserSelected extends User {
  bool isSelected = false;

  UserSelected({
    required String fullName,
    required String phoneNum,
    required String userEmail,
    required String password,
    required String role,
  }) : super(
    fullName: fullName,
    phoneNum: phoneNum,
    userEmail: userEmail,
    password: password,
    role: role,
  );

  void setSelected(bool value) {
    isSelected = !value;
  }

// UserSelected() : super() {
//   // Hàm khởi tạo của lớp con
//   print('Đây là hàm khởi tạo của lớp con');
// }
}
