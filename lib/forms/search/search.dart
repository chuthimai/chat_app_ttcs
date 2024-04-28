import 'package:flutter/material.dart';

class Search extends StatefulWidget{

  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: const Icon(Icons.search, size: 36,),
      hintText: "Search",

      onSubmitted: (String? value) {},
    );
  }
}