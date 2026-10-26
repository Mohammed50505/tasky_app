import 'package:flutter/material.dart';
import 'package:tasks_app/hig_priority_scrren.dart';
import 'package:tasks_app/task_models.dart';

class HigPriorityTaskWidget extends StatefulWidget {
  const HigPriorityTaskWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onReturn,
  });
final VoidCallback onReturn;
  final List<TaskModel> tasks;
  final Function(bool?, int) onTap;

  @override
  State<HigPriorityTaskWidget> createState() => _HigPriorityTaskWidgetState();
}

class _HigPriorityTaskWidgetState extends State<HigPriorityTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: const Color(0xff282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "High Priority Tasks",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF15B86C),
            ),
          ),
          const SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ...widget.tasks.reversed
                        .where((e) => e.isHighpriority)
                        .take(4)
                        .map((e) {
                          return Row(
                            children: [
                              Checkbox(
                                value: e.isDone,
                                onChanged: (bool? value) async {
                                  final index = widget.tasks.indexWhere(
                                    (tasks) => tasks.id == e.id,
                                  );
                                  widget.onTap(value, index);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                activeColor: const Color(0xFF15B86C),
                                checkColor: const Color(0xffffffff),
                              ),
                              Expanded(
                                child: Text(
                                  e.taskName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: e.isDone
                                        ? const Color(0xFFA0A0A0)
                                        : const Color(0xFFFFFCFC),
                                    decoration: e.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: const Color(0xFFA0A0A0),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF282828),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF6E6E6E)),
                    ),
                    child: IconButton(
                      onPressed: ()async {
                    
                     await   Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Hig_priority_scrren();
                            },
                          ),
                        );
                        widget.onReturn();
                      },
                      icon: Icon(Icons.north_east),
                      color: Colors.white,
                      iconSize: 25,
                    
                      
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
