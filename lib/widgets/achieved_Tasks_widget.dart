// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasksWidget extends StatelessWidget {
  AchievedTasksWidget({
    super.key,
    required this.totalTask,
    required this.totalDoneTask,
    required this.percent,
  });

  int totalTask = 0;
  int totalDoneTask = 0;
  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Color(0xff282828),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 3),

              Text("$totalDoneTask Out of $totalTask Done"),
            ],
          ),
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 47,
                  width: 47,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Color(0xFF6D6060),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                '${((percent * 100).toInt())}%',
                style: TextStyle(
                  color: Color(0xFFFFFCFC),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
