import 'package:flutter/material.dart';
import 'package:task_app/screens/add_task_screen.dart';
import 'package:task_app/screens/completed_tasks_screen.dart';
import 'package:task_app/screens/drawer_screen.dart';
import 'package:task_app/screens/favorite_tasks_screen.dart';
import 'package:task_app/screens/pending_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'tabs';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Pending Tasks',
      'name': const PendingTasksScreen(),
    },
    {
      'title': 'Completed Tasks',
      'name': const CompletedTasksScreen(),
    },
    {
      'title': 'Favorite Tasks',
      'name': const FavoriteTasksScreen(),
    },
  ];

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: _selectedPageIndex == 0
            ? <Widget>[
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showModal(context),
                ),
              ]
            : null,
      ),
      drawer: const DrawerScreen(),
      body: _pages[_selectedPageIndex]['name'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              tooltip: 'Add task',
              child: const Icon(Icons.add),
              onPressed: () => _showModal(context),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (value) {
          setState(() {
            _selectedPageIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Pending',
            icon: Icon(Icons.pending_actions),
          ),
          BottomNavigationBarItem(
            label: 'Completed',
            icon: Icon(Icons.done),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SingleChildScrollView(child: AddTaskScreen()),
    );
  }
}
