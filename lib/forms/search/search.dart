import 'package:chat_app_ttcs/db/staff/manage_conversation_dao.dart';
import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/forms/staff/create_conversation_key.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:chat_app_ttcs/screens/staff/detail_conversation_screen.dart';
import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final _manageUser = ManageUserDAO();
  final _manageConversation = ManageConversationDAO();
  List<UserData> _allNormalUser = [];
  List<UserData> _searchNormalUser = [];
  bool _isSuggestionOpened = false;

  void _getAllNormalUser() async {
    final users = await _manageUser.getAllNormalUsers();
    setState(() {
      _allNormalUser = users;
    });
  }

  Future<void> _selectUser(UserData selectedUser) async {
    UserData currentUser = await _manageConversation.getCurrentUser();
    CreateConversationKey conversationKey =
        CreateConversationKey(user1: currentUser, user2: selectedUser);
    final allConversation = await _manageConversation.getAllConversation();

    // kt xem conversation da ton tai chua
    final exitConversation = allConversation
        .where((element) {
          bool compare = element.idConversation.compareTo(conversationKey.key) == 0;
          return compare;
    })
        .toList().isNotEmpty;

    if (!exitConversation) {
      await _manageConversation.createConversationWith2People(
          currentUser: currentUser, otherUser: selectedUser);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetailConversationScreen(
          idConversation: conversationKey.key,
          nameConversation: selectedUser.fullName,
        ),
      ),
    );
  }

  @override
  void initState() {
    _getAllNormalUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SearchAnchor là một widget cung cấp chức năng tìm kiếm với gợi ý kết quả tìm kiếm.
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        // print('lol ---> 1.');
        return SearchBar(
          controller: controller,
          hintText: "Search",
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onSubmitted: (value) {
            // print('lol ---> 2.');
            setState(() {
              _searchNormalUser = _allNormalUser
                  .where((element) => element.fullName
                      .toLowerCase()
                      .contains(value.trim().toLowerCase()))
                  .toList();
              // print('lol ---> 3. _searchNormalUser = $_searchNormalUser');
              controller.openView();
            });
          },
          onChanged: (_) {
            // print('lol ---> 4');
            setState(() {
              controller.clearComposing();
            });
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final numOfListResult = _searchNormalUser.length;
        if (numOfListResult == 0) {
          return List<ListTile>.generate(
              1,
              (index) => const ListTile(
                    title: Text(
                      "No results were found",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ));
        }
        return List<ListTile>.generate(numOfListResult, (int index) {
          return ListTile(
            title: Text(_searchNormalUser.elementAt(index).fullName),
            subtitle: Text(_searchNormalUser.elementAt(index).companyEmail),
            onTap: () async {
              await _selectUser(_searchNormalUser.elementAt(index));
            },
          );
        });
      },
    );
  }
}
