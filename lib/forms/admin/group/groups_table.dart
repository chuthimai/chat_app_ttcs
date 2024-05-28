import 'package:chat_app_ttcs/db/group/manage_group_dao.dart';
import 'package:chat_app_ttcs/forms/admin/group/view_group_form.dart';
import 'package:chat_app_ttcs/models/group/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupTable extends StatefulWidget {
  const GroupTable({super.key});

  @override
  State<GroupTable> createState() => _GroupTableState();
}

class _GroupTableState extends State<GroupTable> {
  List<Group>? _groups;
  final _manageGroup = ManageGroupDAO();


  @override
  void initState() {
    super.initState();
    _getGroups();
  }

  void _getGroups() async{
    final groups = await _manageGroup.getAllGroup();
    setState(() {
      _groups = groups.toList();
    });
  }

  void _openEditGroupForm(Group group) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (cxt) => ViewGroupForm(group: group,),
    );
  }

  bool isCheck = false;

  List<DataCell> _showGroup(Group group) {
    return [
          DataCell(Text(group.nameGroup)),
          DataCell(Align(alignment: Alignment.center, child: Text(group.numOfMem.toString()))),
          DataCell(Text(group.leader.fullName)),
          DataCell(Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _openEditGroupForm(group);
                },
                label: const Text("View"),
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
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
      stream: FirebaseFirestore.instance.collection('AttendingConversation').snapshots(),
      builder: (context, snapshot) {
        if (_groups == null) {
          return const Center(
          child: CircularProgressIndicator(),
        );
        }

        _getGroups();

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
              ),
              DataColumn(
                label: Text("Leader"),
              ),
              DataColumn(
                label: Text(""),
              ),
            ],
            rows: List<DataRow>.generate(
              _groups!.length,
                  (int index) => DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      // Tất cả các dòng được chọn sẽ có màu giống nhau.
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      }

                      // Các dòng chẵn sẽ có màu xám.
                      if (index.isEven) {
                        return Colors.grey.withOpacity(0.1);
                      }
                      return null;
                    }),
                cells: _showGroup(_groups!.elementAt(index)),
              ),
            ),
          ),
        );
      }
    );
  }
}
