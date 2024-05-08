import 'package:chat_app_ttcs/db/user/show_user_dao.dart';
import 'package:chat_app_ttcs/forms/admin/user/user_form.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:flutter/material.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  final dbUser = ShowUserDAO();
  late List<User> allUsers;
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  void _getAllUsers() async {
    final users = await dbUser.getAllUsers();
    setState(() {
      allUsers = users.toList();
      selected = List<bool>.generate(allUsers.length, (int index) => false);
    });
  }

  void _openNewUserForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => UserForm(),
    );
  }

  List<DataCell> _showUser(User user) {
    return [
      DataCell(Text(user.fullName)),
      DataCell(Text(user.gender ? "Male" : "Female")),
      DataCell(Text(user.companyEmail!)),
      DataCell(FutureBuilder(
        future: dbUser.getJobTransfer(user.idJobTransfer),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Text(snapshot.data!.department.nameDepartment);
        },
      )),
      DataCell(FutureBuilder(
        future: dbUser.getJobTransfer(user.idJobTransfer),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Text(snapshot.data!.namePosition);
        },
      )),
      DataCell(Text(user.role)),
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
    if (allUsers == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              // Tất cả các dòng sẽ có màu được chọn giống nhau.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              // Các dòng chẵn sẽ có màu xám.
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
              return null; // Use default value for other states and odd rows.
            }),
            cells: _showUser(allUsers.elementAt(index)),
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
  }
}
