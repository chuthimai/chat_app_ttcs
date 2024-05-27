import 'package:chat_app_ttcs/screens/user/main_screen.dart';
import 'package:chat_app_ttcs/screens/user/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 236, 119, 159),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 131, 45, 74),
  brightness: Brightness.dark, // chinh mau ve dark
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        appBarTheme: const AppBarTheme().copyWith(
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
        dataTableTheme: const DataTableThemeData(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
          dataTextStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 236, 119, 159),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        dataTableTheme: const DataTableThemeData(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
          dataTextStyle: TextStyle(fontWeight: FontWeight.w400),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 16),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
      ),
      home: StreamBuilder(
        // tao 1 ma xac thuc cho 1 phien dang nhap
        // nhận vào một luồng dữ liệu, luồng này phát ra dữ liệu về trạng thái xác thực của người dùng,
        // cho biết liệu họ đã đăng nhập hay chưa.
        stream: FirebaseAuth.instance.authStateChanges(),

        // Hàm này được gọi mỗi khi có một sự thay đổi trong luồng dữ liệu
        builder: (cxt, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen();
          }
          return const StartScreen(titleAppBar: "Login");
        },
      ),
      themeMode: ThemeMode.system,
    );
  }
}
