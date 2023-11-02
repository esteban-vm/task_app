import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required List<Task> tasks}) : _tasks = tasks;
  final List<Task> _tasks;

  @override
  Widget build(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: _tasks.map((task) {
            return ExpansionPanelRadio(
              value: task.id,
              headerBuilder: (_, __) => TaskItem(task: task),
              body: ListTile(
                title: SelectableText.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Title:\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${task.title}\n\n',
                      ),
                      const TextSpan(
                        text: 'Description:\n',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${task.description}\n',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
