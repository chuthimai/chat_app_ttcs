import 'package:chat_app_ttcs/models/group/member.dart';
import 'package:flutter/material.dart';

class MembersTable extends StatefulWidget {
  final List<Member> allMember;

  const MembersTable({super.key, required this.allMember});

  @override
  State<MembersTable> createState() => _MembersTableState();
}

class _MembersTableState extends State<MembersTable> {
  List<DataCell> _showMember(Member user) {
    return [
      DataCell(Text(user.fullName)),
      DataCell(Text(user.gender ? "Male" : "Female")),
      DataCell(Text(user.email)),
      DataCell(Text(user.roleInGroup)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
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
            label: Text("Role in Group"),
          ),
        ],
        rows: List<DataRow>.generate(
          widget.allMember.length,
          (int index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              // Tất cả các dòng được chọn sẽ có màu giống nhau.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }

              // Các dòng chẵn sẽ có màu xám.
              if (index.isEven) {
                return Colors.grey.withOpacity(0.1);
              }
              return null;
            }),
            cells: _showMember(widget.allMember.elementAt(index)),
          ),
        ),
      ),
    );
  }
}
