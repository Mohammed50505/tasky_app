// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, strict_top_level_inference

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/add_tasks.dart';
import 'package:tasks_app/task_models.dart';
import 'package:tasks_app/widgets/achieved_Tasks_widget.dart';
import 'package:tasks_app/widgets/high_priority_task_widget.dart';
import 'package:tasks_app/widgets/tasks_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isDone = true;
  String? username;
  List<TaskModel> tasks = [];
  int totalTask = 0;
  int totalDoneTask = 0;
  double percent = 0;
  @override
  void initState() {
    super.initState();
    _LodeUserName();
    _Lodatask();
    _calculatePercent();
  }

  void _Lodatask() async {
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString("tasks");

    if (finalTask != null) {
      final List<dynamic> taskAfterDecode = jsonDecode(finalTask);

      final List<TaskModel> tasks = taskAfterDecode
          .map((e) => TaskModel.fromJson(e))
          .toList();

      setState(() {
        this.tasks = tasks;
        _calculatePercent();
      });
    }
  }

  _calculatePercent() {
    totalTask = tasks.length;
    totalDoneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTask / totalTask;
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final pref = await SharedPreferences.getInstance();
    final uptateTask = tasks.map((e) => e.toMap()).toList();
    pref.setString("tasks", jsonEncode(uptateTask));
  }

  void _LodeUserName() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString("username");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //// FloatingButton?
      floatingActionButton: SizedBox(
        height: 40,

        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddTasks();
                },
              ),
            );
            _Lodatask();
          },

          backgroundColor: Color(0xff15B86C),
          foregroundColor: Color(0xffffffff),
          label: Text("Add New Task"),
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset("assets/Thumbnail.png", width: 40, height: 40),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Good Evening: $username",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "One task at a time.One step closer.",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Yuhuu ,Your work Is ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),

              Row(
                children: [
                  Text(
                    "almost done ! ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset("assets/hade.png"),
                ],
              ),
              const SizedBox(height: 12),

              AchievedTasksWidget(
                totalTask: totalTask,
                totalDoneTask: totalDoneTask,
                percent: percent,
              ),
              const SizedBox(height: 5),
              HigPriorityTaskWidget(
                tasks: tasks,
                onTap: (bool? value, int? index) {
                  _doneTask(value, index);
                },
                onReturn: () => _Lodatask(),
              ),
              /////////////////////////////////
              const SizedBox(height: 8),
              Text(
                "MyTasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: tasks_list_widget(
                  emptymessage: "No Data",
                  Tasks: tasks,
                  onTap: (bool? value, int? index) {
                    _doneTask(value, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
