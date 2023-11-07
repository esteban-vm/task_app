import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/services/guid_gen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Add Task',
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
                    final task = Task(
                      id: GUIDGen.generate(),
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateTime.now().toString(),
                    );
                    context.read<TaskBloc>().add(AddTask(task: task));
                    context.read<TaskBloc>().add(GetTasks());
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
