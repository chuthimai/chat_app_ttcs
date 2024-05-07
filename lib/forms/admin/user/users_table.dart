import 'package:chat_app_ttcs/models/user/user_seclected.dart';
import 'package:chat_app_ttcs/forms/admin/user/user_form.dart';
import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // var userSelected = UserSelected(
  //   fullName: "chu thi mai",
  //   phoneNum: "",
  //   userEmail: "",
  //   password: "",
  //   role: "",
  // );

  List<DataCell> _showUser(User user) {
    return [
          DataCell(Text(user.fullName)),
          DataCell(Text(user.gender ? "Male" : "Female")),
          DataCell(Text(user.companyEmail!)),
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
        ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        print('users_table ${snapshot.data!.docs.length}');
        if (snapshot.hasData == false || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No users found."),
          );
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        final allUsers = snapshot.data!.docs;
        List<bool> selected = List<bool>.generate(allUsers.length, (int index) => false);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            checkboxHorizontalMargin: 10,
            // showCheckboxColumn: true,
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
            rows: List<DataRow>.generate(
              allUsers.length,
              (int index) => DataRow(
                color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  print('datarow ${index}');
                  // Tất cả các dòng sẽ có màu được chọn giống nhau.
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  }
                  // Các dòng chẵn sẽ có màu xám.
                  if (index.isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null; // Use default value for other states and odd rows.
                }),
                cells: _showUser(User.toUser(allUsers[0].data())),
                selected: selected[index],
                onSelectChanged: (bool? value) {
                  setState(() {
                    selected[index] = value!;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
