import 'package:chat_app_ttcs/forms/admin/group/members_table.dart';
import 'package:chat_app_ttcs/forms/admin/user/users_table.dart';
import 'package:chat_app_ttcs/forms/search/search.dart';
import 'package:flutter/material.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({super.key});

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          // key: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Group",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Group Name",
                ),
                onSaved: (value) {},
                validator: (value) {
                  // Kt trong database
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                readOnly: true,
                initialValue: "Someone",
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Leader",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                readOnly: true,
                initialValue: "3",
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Number of Members",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SearchUser(),
              const SizedBox(
                height: 16,
              ),
              MembersTable(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                    ),
                    child: const Text("Save"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(),
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
