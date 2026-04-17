// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tasks_app/main_scrren.dart';
import 'package:tasks_app/welcom_scrren.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();

  String? username = pref.getString('username');

  runApp(MainApp(username: username));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        switchTheme: SwitchThemeData(

          
        ),
        appBarTheme: AppBarTheme(
          
          backgroundColor: Color(0xFF181818),
          titleTextStyle: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20),
        ),

        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xff15B86C),
          background: Color(0xFF181818),
          surface: Color(0xFF181818),
        ),
        scaffoldBackgroundColor: const Color(0xFF181818),
      ),
      home: username == null ? WelcomScreen() : MainScrren(),
    );
  }
}


// mohammad awd help his bro