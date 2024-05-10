import 'package:chat_app_ttcs/db/admin/show_user_dao.dart';
import 'package:chat_app_ttcs/forms/admin/user/new_user_form.dart';
import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:flutter/material.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  final _dbUser = ShowUserDAO();
  List<UserData> _allUsers = [];
  List<Position> _allPositions = [];
  List<JobTransfer> _allJobTrans = [];
  List<bool> _selected = [];

  @override
  void initState() {
    _getAllUsers();
    _getAllPosition();
    _getAllJobTransfer();
    super.initState();
  }

  void _getAllPosition() async {
    final positions = await _dbUser.getAllPosition();
    setState(() {
      _allPositions = positions.toList();
    });
  }

  void _getAllJobTransfer() async {
    final jobTrans = await _dbUser.getAllJobTransfer();
    setState(() {
      _allJobTrans = jobTrans.toList();
    });
  }

  void _getAllUsers() async {
    final users = await _dbUser.getAllUsers();
    setState(() {
      _allUsers = users.toList();
      _selected = List<bool>.generate(_allUsers.length, (int index) => false);
    });
  }

  void _openNewUserForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => const NewUserForm(),
    );
    _getAllUsers();
    _getAllJobTransfer();
  }

  List<DataCell> _showUser(UserData user) {
    final JobTransfer jobTran = _allJobTrans
        .where((element) => element.idJobTransfer == user.idJobTransfer)
        .first;
    final Position position = _allPositions
        .where((element) => element.idPosition == jobTran.idNewPosition)
        .first;

    return [
      DataCell(Text(user.fullName)),
      DataCell(Text(user.gender ? "Male" : "Female")),
      DataCell(Text(user.companyEmail)),
      DataCell(Text(position.department.nameDepartment)),
      DataCell(Text(position.namePosition)),
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
    if (_allPositions.isEmpty ||
        _allJobTrans.isEmpty ||
        _allPositions.isEmpty) {
      return const CircularProgressIndicator();
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
          _allUsers.length,
          (int index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              // Tất cả các dòng được chọn sẽ có màu giống nhau.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              // Các dòng chẵn sẽ có màu xám.
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
              return null;
            }),
            cells: _showUser(_allUsers.elementAt(index)),
            selected: _selected[index],
            onSelectChanged: (bool? value) {
              setState(() {
                _selected[index] = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
