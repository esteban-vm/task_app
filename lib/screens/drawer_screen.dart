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
          children: [
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
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(HomeScreen.id);
                  },
                  child: ListTile(
                    trailing: Text(state.tasks.length.toString()),
                    title: const Text('My Tasks'),
                    leading: const Icon(Icons.folder_special),
                  ),
                );
              },
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RecycleBinScreen.id);
              },
              child: const ListTile(
                trailing: Text('0'),
                title: Text('Bin'),
                leading: Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
