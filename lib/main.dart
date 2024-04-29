import 'package:chat_app_ttcs/screens/admin/admin_main_screen.dart';
import 'package:chat_app_ttcs/screens/admin/edit_user_screen.dart';
import 'package:chat_app_ttcs/screens/staff/view_list_friend_screen.dart';
import 'package:chat_app_ttcs/screens/user/start_screen.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 236, 119, 159),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 131, 45, 74),
  brightness: Brightness.dark, // chinh mau ve dark
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(128, 236, 119, 159),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 222, 36, 96),
        )),
        dataTableTheme: DataTableThemeData(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
          dataTextStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 236, 119, 159),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        dataTableTheme: DataTableThemeData(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
          dataTextStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 16),
        )
      ),
      home: const ViewListFriendScreen(),
      themeMode: ThemeMode.dark,
    );
  }
}
