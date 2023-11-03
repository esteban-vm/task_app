import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Edit Task',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
            ),
            Container(height: 10.0),
            TextField(
              minLines: 3,
              maxLines: 5,
              controller: descriptionController,
              decoration: const InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(),
              ),
            ),
            Container(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final newTask = Task(
                      id: task.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateTime.now().toString(),
                      isCompleted: false,
                      // isDeleted: false,
                      isFavorite: task.isFavorite,
                    );
                    context
                        .read<TaskBloc>()
                        .add(EditTask(oldTask: task, newTask: newTask));
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
