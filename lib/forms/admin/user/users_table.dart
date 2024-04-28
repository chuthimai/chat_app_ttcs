import 'package:chat_app_ttcs/models/user/user_seclected.dart';
import 'package:chat_app_ttcs/forms/admin/user/user_form.dart';
import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:flutter/material.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  void _openNewUserForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => UserForm(),
    );
  }

  var userSelected = UserSeclected(
    fullName: "",
    phoneNum: "",
    userEmail: "",
    password: "",
    role: "",
  );

  DataRow _showUser() {
    return DataRow(
        selected: userSelected.isSelected,
        onSelectChanged: (bool? b) {
          setState(() {
            userSelected.setSelected(userSelected.isSelected);
          });
        },
        cells: [
          DataCell(Text("Chu Thi Mai")),
          DataCell(Text("Female")),
          DataCell(Text("MaiCT@cp.vn")),
          DataCell(Text("None")),
          DataCell(Text("None")),
          DataCell(Text("User")),
          DataCell(Row(
            children: [
              ElevatedButton.icon(
                onPressed: _openNewUserForm,
                label: const Text("Edit"),
                icon: const Icon(
                  Icons.edit,
                  size: 13,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(213, 246, 189, 208)),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text("Delete"),
                icon: const Icon(
                  Icons.delete,
                  size: 13,
                ),
              ),
            ],
          ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        checkboxHorizontalMargin: 10,
        showCheckboxColumn: true,
        columns: const [
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("Gender"),
          ),
          DataColumn(
            label: Text("Email"),
          ),
          DataColumn(
            label: Text("Department"),
          ),
          DataColumn(
            label: Text("Position"),
          ),
          DataColumn(
            label: Text("Role"),
          ),
          DataColumn(
            label: Text(""),
          ),
        ],
        rows: [
          _showUser(),
          _showUser(),
          _showUser(),
        ],
      ),
    );
  }
}
