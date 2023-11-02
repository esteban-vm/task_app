import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> pendingTasks = state.pendingTasks;
        int completedTaskCount = state.completedTasks.length;

        return SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: Chip(
                  label: Text(
                    '${pendingTasks.length} Pending | $completedTaskCount Completed',
                  ),
                ),
              ),
              TaskList(tasks: pendingTasks),
            ],
          ),
        );
      },
    );
  }
}
