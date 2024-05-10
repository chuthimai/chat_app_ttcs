import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final _manageUser = ManageUserDAO();
  List<UserData> _allNormalUser = [];
  List<UserData> _searchNormalUser = [];
  bool _isSuggestionOpened = false;

  void _getAllNormalUser() async {
    final users = await _manageUser.getAllNormalUsers();
    setState(() {
      _allNormalUser = users;
    });
  }

  @override
  void initState() {
    _getAllNormalUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        if (_allNormalUser.isEmpty) return const CircularProgressIndicator();
        return SearchBar(
          controller: controller,
          hintText: "Search",
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onSubmitted: (value) {
            setState(() {
              _searchNormalUser = _allNormalUser
                  .where((element) => element.fullName
                      .toLowerCase()
                      .contains(value.trim().toLowerCase()))
                  .toList();
            });
            controller.openView();
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
            onTap: () {
              setState(() {
                controller
                    .closeView(_searchNormalUser.elementAt(index).fullName);
              });
            },
          );
        });
      },
    );
  }
}
