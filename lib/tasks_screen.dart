import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/task_models.dart';
import 'package:tasks_app/widgets/tasks_list_widget.dart';

class TasksScreeen extends StatefulWidget {
  const TasksScreeen({super.key});

  @override
  State<TasksScreeen> createState() => _TasksScreeenState();
}

class _TasksScreeenState extends State<TasksScreeen> {
  List<TaskModel> Todotasks = [];

  @override
  void initState() {
    super.initState();
    _Lodatask();
  }

  void _Lodatask() async {
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        Todotasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((e) => e.isDone == false)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To DO Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: tasks_list_widget(
          emptymessage: "No task Found",
          Tasks: Todotasks,
          onTap: (value, index) async {
            setState(() {
              Todotasks[index].isDone = value ?? false;
            });

            final pref = await SharedPreferences.getInstance();

            final allData = pref.getString("tasks");
            if (allData != null) {
              List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((e) => TaskModel.fromJson(e))
                  .toList();

              final newIndex = allDataList.indexWhere(
                (e) => e.id == Todotasks[index].id,
              );

              allDataList[newIndex] = Todotasks[index];

              pref.setString(
                "tasks",
                jsonEncode(allDataList.map((e) => e.toMap()).toList()),
              );
              _Lodatask();
            }
          },
        ),
      ),
    );
  }
}
