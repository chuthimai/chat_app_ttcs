import 'package:chat_app_ttcs/forms/admin/group/group_form.dart';
import 'package:flutter/material.dart';

class GroupTable extends StatefulWidget {
  const GroupTable({super.key});

  @override
  State<GroupTable> createState() => _GroupTableState();
}

class _GroupTableState extends State<GroupTable> {

  void _openNewGroupForm() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => GroupForm(),
    );
  }

  bool isCheck = false;

  DataRow _showGroup() {
    return DataRow(
        selected: isCheck,
        onSelectChanged: (bool? b) {
          setState(() {
            isCheck = !isCheck;
          });
        },
        cells: [
          DataCell(Text("Group 1")),
          DataCell(Text("3")),
          DataCell(Text("MaiCT")),
          DataCell(Row(
            children: [
              ElevatedButton.icon(
                onPressed: _openNewGroupForm,
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
            label: Text("Name Group"),
          ),
          DataColumn(
            label: Text("Number of members"),
            numeric: true,
            // onSort: (num, b) {},
          ),
          DataColumn(
            label: Text("Leader"),
          ),
          DataColumn(
            label: Text(""),
          ),
        ],
        rows: [
          _showGroup(),
          _showGroup(),
        ],
      ),
    );
  }
}
