import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/recycle_bin_screen.dart';
import 'package:task_app/screens/sign_in_screen.dart';

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
                    '${state.pendingTasks.length} | ${state.completedTasks.length}',
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
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return IconButton(
                  icon: state.isDark
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode),
                  onPressed: () {
                    if (state.isDark) {
                      context.read<ThemeBloc>().add(DarkOff());
                    } else {
                      context.read<ThemeBloc>().add(DarkOn());
                    }
                  },
                  iconSize: 30.0,
                );
              },
            ),
            ListTile(
              onTap: () {
                GetStorage().remove('token');
                Navigator.pushReplacementNamed(context, SignInScreen.id);
              },
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
