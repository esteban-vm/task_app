import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (_) {
          context.read<TaskBloc>().add(UpdateTask(task: task));
        },
      ),
      onLongPress: () {
        context.read<TaskBloc>().add(DeleteTask(task: task));
      },
    );
  }
}
