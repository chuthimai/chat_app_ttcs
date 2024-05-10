import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget{

  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: const Icon(Icons.search, size: 36,),
      hintText: "Search",

      onSubmitted: (String? value) {},
    );
  }
}