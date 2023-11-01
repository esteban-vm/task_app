import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return ListTile(
      title: Text(
        task.content,
        style: TextStyle(
          decoration: task.isDone! ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: _handleChanged(context, task),
      ),
      onLongPress: _handleLongPress(context, task),
    );
  }

  void Function(bool? _)? _handleChanged(BuildContext context, Task task) {
    if (!task.isDeleted!) {
      return (_) => context.read<TaskBloc>().add(UpdateTask(task: task));
    } else {
      return null;
    }
  }

  void Function() _handleLongPress(BuildContext context, Task task) {
    return () {
      if (task.isDeleted!) {
        context.read<TaskBloc>().add(DeleteTask(task: task));
      } else {
        context.read<TaskBloc>().add(RemoveTask(task: task));
      }
    };
  }
}
