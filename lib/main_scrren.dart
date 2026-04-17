// ignore_for_file: avoid_print, unused_field, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasks_app/completed_task_scrren.dart';

import 'package:tasks_app/home_screen.dart';
import 'package:tasks_app/profile_screen.dart';
import 'package:tasks_app/tasks_screen.dart';

class MainScrren extends StatefulWidget {
  MainScrren({super.key});

  @override
  State<MainScrren> createState() => _MainScrrenState();
}

class _MainScrrenState extends State<MainScrren> {
  int _currentIndex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    TasksScreeen(),
    CompletedTaskScrren(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          print(index);
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xFFc6C6C6),
        selectedItemColor: Color(0xFF15886C),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Home.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xFF15B86c) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          ///////////
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/TODO.svg",

              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xFF15B86c) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "To Do",
          ),

          /////////////////////////
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/completed.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xFF15B86c) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "Completed",
          ),
          ////////////////////////
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/profile.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xFF15B86c) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: _screen[_currentIndex],
    );
  }
}
