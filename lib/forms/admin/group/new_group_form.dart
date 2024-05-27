import 'package:chat_app_ttcs/db/group/manage_group_dao.dart';
import 'package:chat_app_ttcs/forms/admin/group/members_table.dart';
import 'package:chat_app_ttcs/models/group/member.dart';
import 'package:flutter/material.dart';

class NewGroupForm extends StatefulWidget {
  final List<Member> allMember;
  const NewGroupForm({super.key, required this.allMember});

  @override
  State<NewGroupForm> createState() => _NewGroupFormState();
}

class _NewGroupFormState extends State<NewGroupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _db = ManageGroupDAO();
  String _enterNameGroup = '';
  Member? _enterLeader;
  List<Member> _localAllMember = [];

  void _clickSave() {
    final isValid = _formKey.currentState!.validate();

    if(!isValid) return;
    _formKey.currentState!.save();

    // create group
    _db.createGroup(nameConversation: _enterNameGroup, allMember: _localAllMember);

    // exit overlay
    Navigator.pop(context);

    // show notification add new group successfully
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Add new group successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _localAllMember = widget.allMember.toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New Group",
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
                onSaved: (value) {
                  _enterNameGroup = value!;
                },
                validator: (value) {
                  if (value == null || value == '') return "Please enter group name";
                  if (value == 'default') return "Group name cannot be 'default'";
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                readOnly: true,
                initialValue: _localAllMember.length.toString(),
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Number of Members",
                ),
                validator: (value) {
                  if (int.parse(value!) < 3) return "The group must have at least 3 members";
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: _localAllMember.map((member) {
                      return DropdownMenuItem(
                        value: member,
                        child: Text(member.fullName),
                      );
                    }).toList(),
                    value: _enterLeader,
                    hint: const Text("Leader"),
                    onChanged: (value) {
                      setState(() {
                        _enterLeader = value!;
                        _localAllMember = _localAllMember.map((member) {
                          if (member.idUser == value.idUser) {
                            member.roleInGroup = "Leader";
                          } else {
                            member.roleInGroup = "Member";
                          }
                          return member;
                        }).toList();
                      });
                    },
                    validator: (value) {
                      if (value == null) return "Choose a leader";
                      return null;
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              MembersTable(allMember: _localAllMember,),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _clickSave,
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
