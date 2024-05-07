import 'package:chat_app_ttcs/db/main/db_role.dart';
import 'package:chat_app_ttcs/screens/admin/admin_main_screen.dart';
import 'package:chat_app_ttcs/screens/staff/view_list_friend_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserRole = DBRole();
    return FutureBuilder(
      future: currentUserRole.getRole(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Bat loi va hien thi loi
          return Text('Error: ${snapshot.error}');
        } else {
          final role = snapshot.data;
          if (role == 'Admin') {
            return const AdminMainScreen();
          } else if (role == 'Employee'){
            return const ViewListFriendScreen();
          } else return Scaffold();
        }
      },
    );
  }
}