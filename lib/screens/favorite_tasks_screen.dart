import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> favoriteTasks = state.favoriteTasks;

        return SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: Chip(
                  label: Text('${favoriteTasks.length} Tasks'),
                ),
              ),
              TaskList(tasks: favoriteTasks),
            ],
          ),
        );
      },
    );
  }
}
