import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_checker.dart';
import 'package:task_app/widgets/task_info.dart';
import 'package:task_app/widgets/task_menu.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                !task.isFavorite
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(width: 10.0),
                TaskInfo(task: task),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              TaskChecker(task: task),
              TaskMenu(task: task),
            ],
          ),
        ],
      ),
    );
  }
}
