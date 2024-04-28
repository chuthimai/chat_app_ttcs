import 'package:flutter/material.dart';

class MembersTable extends StatefulWidget {
  const MembersTable({super.key});

  @override
  State<MembersTable> createState() => _MembersTableState();
}

class _MembersTableState extends State<MembersTable> {
  DataRow _showMember() {
    return DataRow(
        cells: [
          DataCell(Text("Chu Thi Mai")),
          DataCell(Text("Female")),
          DataCell(Text("MaiCT@cp.vn")),
          DataCell(Text("None")),
          DataCell(Text("None")),
          DataCell(Text("Leader")),
          DataCell(Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text("Leader"),
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
            label: Text("Role in Group"),
          ),
          DataColumn(
            label: Text(""),
          ),
        ],
        rows: [
          _showMember(),
          _showMember(),
          _showMember(),
        ],
      ),
    );
  }
}
