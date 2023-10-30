import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required List<Task> tasks}) : _tasks = tasks;
  final List<Task> _tasks;

  @override
  Widget build(context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (_, index) {
          Task task = _tasks[index];
          return TaskItem(task: task);
        },
      ),
    );
  }
}
