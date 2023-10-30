import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/screens/drawer_screen.dart';
import 'package:task_app/widgets/task_list.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({super.key});
  static const id = 'recycle_bin';

  @override
  Widget build(context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          drawer: const DrawerScreen(),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Center(
                  child: Chip(
                    label: Text(
                      '${state.removedTasks.length} Tasks',
                    ),
                  ),
                ),
                TaskList(tasks: state.removedTasks),
              ],
            ),
          ),
        );
      },
    );
  }
}
