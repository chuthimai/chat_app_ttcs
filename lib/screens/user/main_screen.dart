import 'package:chat_app_ttcs/db/main/db_role.dart';
import 'package:chat_app_ttcs/screens/admin/admin_main_screen.dart';
import 'package:chat_app_ttcs/screens/staff/view_list_friend_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _currentUserRole = DBRole();
  String _role = '';

  @override
  void initState() {
    _getRoleUser();
    super.initState();
  }

  void _getRoleUser() async {
    String role = await _currentUserRole.getRole();
    setState(() {
      _role = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_role == '' || FirebaseAuth.instance.currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }else if (_role == 'Admin') {
      return const AdminMainScreen();
    } else if (_role == 'Normal User') {
      return const ViewListFriendScreen();
    }
    return const Scaffold();
  }
}
