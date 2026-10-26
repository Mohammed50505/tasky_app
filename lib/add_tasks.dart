// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/task_models.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

final GlobalKey<FormState> _key = GlobalKey<FormState>();

class _AddTasksState extends State<AddTasks> {
  bool isHinprity = true;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Color(0xffffffff)),
        title: Text(
          "New Task",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22),
                  Text(
                    "Task Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),

                  //// Filed TasksName
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controllerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please Enter Your full name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Finish UI design for login screen",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6D6D6D),
                      ),
                      filled: true,
                      fillColor: Color(0xff282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 55),
                  Text(
                    "Task Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),

                  // Filed Task Description
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controllerDescription,
                    maxLines: 5,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                   
                    decoration: InputDecoration(
                      hintText:
                          "Finish onboarding UI and hand off to\n devs by Thursday.",

                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6D6D6D),
                      ),

                      filled: true,
                      fillColor: Color(0xff282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High Priority  ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff),
                        ),
                      ),
                      //// Switch ////
                      Switch(
                        value: isHinprity,

                        onChanged: (bool value) {
                          setState(() {
                            isHinprity = value;
                          });
                        },

                        activeTrackColor: Color(0xff15B86C),
                          activeColor: Colors.white, 
                      ),
                    ],
                  ),

                  const SizedBox(height: 140),
                  //// Button ///
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
   final pref = await SharedPreferences.getInstance();

                        final taskjson = pref.getString("tasks");

                                 List<dynamic> ListTasks = [];

                        if (taskjson != null) {
                          ListTasks = jsonDecode(taskjson);
                        }

                        TaskModel model = TaskModel(
                          id:ListTasks.length+1,
                          taskName: controllerName.text,
                          taskDescription: controllerDescription.text,
                          isHighpriority: isHinprity,
                          isDone: false,
                        );

                     

               

                        ListTasks.add(model.toMap());

                        final taskEncode = jsonEncode(ListTasks);
                        await pref.setString("tasks", taskEncode);

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fixedSize: Size(377, 48),
                    ),
                    label: Text(
                      "add Task",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
