import 'package:chat_app_ttcs/forms/admin/group/new_group_form.dart';
import 'package:chat_app_ttcs/forms/admin/user/new_user_form.dart';
import 'package:chat_app_ttcs/forms/admin/user/users_table.dart';
import 'package:chat_app_ttcs/forms/search/search.dart';
import 'package:chat_app_ttcs/models/group/member.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:chat_app_ttcs/providers/selected_users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllUsersScreen extends ConsumerStatefulWidget {
  const AllUsersScreen({super.key});

  @override
  ConsumerState<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends ConsumerState<AllUsersScreen> {
  void _openNewUserForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => const NewUserForm(),
    );
  }

  void _openNewGroupForm(List<Member> allMember) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => NewGroupForm(allMember: allMember),
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
                onPressed: () {
                  _openNewGroupForm(ref
                      .read(selectedUsersProvider)
                      .map((e) => Member(
                            e.idUser,
                            e.fullName,
                            e.gender,
                            e.companyEmail,
                          ))
                      .toList());
                },
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
          const Expanded(
            child: SingleChildScrollView(child: UserTable()),
          )
        ],
      ),
    );
  }
}
