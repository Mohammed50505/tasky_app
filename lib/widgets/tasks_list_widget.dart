// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'package:tasks_app/task_models.dart';

class tasks_list_widget extends StatelessWidget {
  tasks_list_widget({
    super.key,
    required this.Tasks,
    required this.onTap,
    required this.emptymessage,
  });
  List<TaskModel> Tasks;
  final Function(bool?, int) onTap;
  final String emptymessage;
  @override
  Widget build(BuildContext context) {
    return Tasks.isEmpty
        ? Center(child: Text(emptymessage, style: TextStyle(fontSize: 20)))
        : ListView.builder(
            itemCount: Tasks.length,
            padding: EdgeInsets.only(bottom: 50),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff282828),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  ///////chekbox///////////
                  child: Row(
                    children: [
                      Checkbox(
                        value: Tasks[index].isDone,
                        onChanged: (bool? value) async {
                          onTap(value, index);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: Color(0xFF15B86C),
                        checkColor: Color(0xffffffff),
                      ),
                      const SizedBox(width: 19),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Tasks[index].taskName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Tasks[index].isDone
                                    ? Color(0xFFA0A0A0)
                                    : Color(0xFFFFFCFC),
                                decoration: Tasks[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                              ),
                            ),
                            if (Tasks[index].taskDescription.isNotEmpty)
                              Text(
                                Tasks[index].taskDescription,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Tasks[index].isDone
                                      ? Color(0xFFA0A0A0)
                                      : Color(0xFFFFFCFC),
                                  decoration: Tasks[index].isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationColor: Color(0xFFA0A0A0),
                                ),
                              ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
