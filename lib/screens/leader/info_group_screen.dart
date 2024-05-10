import 'package:chat_app_ttcs/forms/search/search.dart';
import 'package:chat_app_ttcs/screens/leader/all_members_screen.dart';
import 'package:chat_app_ttcs/screens/leader/delete_member_screen.dart';
import 'package:chat_app_ttcs/screens/leader/leader_screen.dart';
import 'package:flutter/material.dart';

class InfoGroupScreen extends StatelessWidget {

  const InfoGroupScreen({super.key});

  void _selectAllMembers(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AllMembersScreen(),
      ),
    );
  }

  void _selectDeleteMember(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DeleteMemberScreen(),
      ),
    );
  }

  void _selectLeader(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => LeaderScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Name Group"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            SearchUser(),
            SizedBox(height: 16,),
            ListTile(
              title: Text(
                "All Members",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                _selectAllMembers(context);
              },
            ),
            ListTile(
              title: Text(
                "Delete Member",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                _selectDeleteMember(context);
              },
            ),
            ListTile(
              title: Text(
                "Leader",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                _selectLeader(context);
              },
            ),
            ListTile(
              title: Text(
                "Leave Group",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                ),
              ),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}