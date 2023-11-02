import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> completedTasks = state.completedTasks;

        return SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: Chip(
                  label: Text('${completedTasks.length} Tasks'),
                ),
              ),
              TaskList(tasks: completedTasks),
            ],
          ),
        );
      },
    );
  }
}
