import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/pages/add_task_page.dart';
import 'package:task_app/widgets/task_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasks = state.tasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Task App'),
            actions: <Widget>[
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Center(
                  child: Chip(
                    label: Text('${state.tasks.length} Tasks'),
                  ),
                ),
                TaskList(tasks: tasks),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add task',
            child: const Icon(Icons.add),
            onPressed: () => _addTask(context),
          ),
        );
      },
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SingleChildScrollView(child: AddTaskPage()),
    );
  }
}
