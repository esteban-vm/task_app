import 'package:flutter/material.dart';
import 'package:task_app/screens/drawer_screen.dart';
import 'package:task_app/widgets/task_list.dart';

class RecycleBinScreen extends StatelessWidget {
  static const id = 'recycle_bin';

  const RecycleBinScreen({super.key});

  @override
  Widget build(context) {
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
      body: const SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Chip(
                label: Text('Tasks'),
              ),
            ),
            TaskList(tasks: []),
          ],
        ),
      ),
    );
  }
}
