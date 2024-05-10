import 'package:chat_app_ttcs/forms/admin/group/groups_table.dart';
import 'package:flutter/material.dart';

import '../../forms/search/search.dart';

class AllGroupScreen extends StatefulWidget {

  const AllGroupScreen({super.key});

  @override
  State<AllGroupScreen> createState() => _AllGroupScreenState();
}

class _AllGroupScreenState extends State<AllGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SearchUser(),
          const SizedBox(
            height: 20,
          ),
          GroupTable(),
        ],
      ),
    );
  }
}