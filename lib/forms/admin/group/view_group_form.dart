import 'package:chat_app_ttcs/forms/admin/group/members_table.dart';
import 'package:chat_app_ttcs/models/group/group.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:flutter/material.dart';

class ViewGroupForm extends StatefulWidget {
  final Group group;
  const ViewGroupForm({super.key, required this.group});

  @override
  State<ViewGroupForm> createState() => _ViewGroupFormState();
}

class _ViewGroupFormState extends State<ViewGroupForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final allMember = widget.group.allMember;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          // key: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "View Group",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                maxLength: 50,
                readOnly: true,
                initialValue: widget.group.nameGroup,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Group Name",
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                readOnly: true,
                initialValue: allMember.length.toString(),
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Number of Members",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              MembersTable(allMember: allMember,),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                    ),
                    child: const Text("Cancel"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
