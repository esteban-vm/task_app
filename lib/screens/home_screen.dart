import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/add_task_screen.dart';
import 'package:task_app/screens/drawer_screen.dart';
import 'package:task_app/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home';

  const HomeScreen({super.key});

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
                icon: const Icon(Icons.add),
                onPressed: () => _showModal(context),
              ),
            ],
          ),
          drawer: const DrawerScreen(),
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
            onPressed: () => _showModal(context),
          ),
        );
      },
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SingleChildScrollView(child: AddTaskScreen()),
    );
  }
}
