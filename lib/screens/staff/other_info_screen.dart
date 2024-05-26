import 'package:chat_app_ttcs/db/staff/manage_conversation_dao.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:flutter/material.dart';

class OtherInfoScreen extends StatefulWidget {
  final String idConversation;

  const OtherInfoScreen({super.key, required this.idConversation});

  @override
  State<OtherInfoScreen> createState() => _OtherInfoScreenState();
}

class _OtherInfoScreenState extends State<OtherInfoScreen> {
  final manageConversation = ManageConversationDAO();
  UserData? friend;
  Position? friendPosition;

  void getFriend() async {
    List<UserData> allMember = await manageConversation
        .getAllMemberOfConversation(widget.idConversation);
    UserData currentUser = await manageConversation.getCurrentUser();

    if (currentUser.idUser == allMember[0].idUser) {
      friend = allMember[1];
    } else {
      friend = allMember[0];
    }

    Position position =
        await manageConversation.getPosition(friend!.idJobTransfer);

    setState(() {
      friendPosition = position;
    });
  }

  @override
  void initState() {
    super.initState();
    getFriend();
  }

  @override
  Widget build(BuildContext context) {
    if (friend == null || friendPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(friend!.avatar),
                  maxRadius: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  friend!.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  friend!.companyEmail,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Info",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: const Text("Full name: "),
                          title: Text(friend!.fullName),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          leading: const Text("Gender: "),
                          title: Text(friend!.gender ? "Male" : "Female"),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          leading: const Text("Position: "),
                          title: Text(friendPosition!.namePosition),
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          leading: const Text("Department: "),
                          title:
                              Text(friendPosition!.department.nameDepartment),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
