import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/models/task.dart';

class TaskInfo extends StatelessWidget {
  const TaskInfo({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            task.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          Text(
            DateFormat()
                .add_yMMMd()
                .add_Hms()
                .format(DateTime.parse(task.date)),
          ),
        ],
      ),
    );
  }
}
