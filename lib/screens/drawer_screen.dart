import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/recycle_bin_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 20.0,
              ),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) => GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(
                  HomeScreen.id,
                ),
                child: ListTile(
                  title: const Text('My Tasks'),
                  leading: const Icon(Icons.folder_special),
                  trailing: Text(
                    state.allTasks.length.toString(),
                  ),
                ),
              ),
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) => GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(
                  RecycleBinScreen.id,
                ),
                child: ListTile(
                  title: const Text('Bin'),
                  leading: const Icon(Icons.delete),
                  trailing: Text(
                    state.removedTasks.length.toString(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
