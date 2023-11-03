import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

class TaskChecker extends StatelessWidget {
  const TaskChecker({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return Checkbox(
      value: task.isCompleted,
      onChanged: !task.isRemoved
          ? (_) => context.read<TaskBloc>().add(ToggleCompletedTask(task: task))
          : null,
    );
  }
}
