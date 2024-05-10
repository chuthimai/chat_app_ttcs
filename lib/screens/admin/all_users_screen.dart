import 'package:chat_app_ttcs/forms/admin/group/group_form.dart';
import 'package:chat_app_ttcs/forms/admin/user/new_user_form.dart';
import 'package:chat_app_ttcs/forms/admin/user/users_table.dart';
import 'package:chat_app_ttcs/forms/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  void _openNewUserForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => const NewUserForm(),
    );
  }

  void _openNewGroupForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => const GroupForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SearchUser(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton.extended(
                onPressed: _openNewUserForm,
                label: const Row(
                  children: [Icon(Icons.add), Text("Add Account")],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton.extended(
                onPressed: _openNewGroupForm,
                label: const Row(
                  children: [Icon(Icons.add), Text("Add Group")],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          const Expanded(child: SingleChildScrollView(child: UserTable()),)
        ],
      ),
    );
  }
}
