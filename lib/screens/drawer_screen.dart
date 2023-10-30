import 'package:flutter/material.dart';

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
            const ListTile(
              trailing: Text('0'),
              title: Text('My Tasks'),
              leading: Icon(Icons.folder_special),
            ),
            const Divider(),
            const ListTile(
              trailing: Text('0'),
              title: Text('Bin'),
              leading: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
