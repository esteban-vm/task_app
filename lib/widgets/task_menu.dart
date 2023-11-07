import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/edit_task_screen.dart';

class TaskMenu extends StatelessWidget {
  const TaskMenu({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        if (!task.isRemoved) {
          return <PopupMenuItem>[
            // Edition
            PopupMenuItem(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => SingleChildScrollView(
                    child: EditTaskScreen(task: task),
                  ),
                );
              },
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ),
            // Favorite / Unfavorite
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(ToggleFavoriteTask(task: task));
                context.read<TaskBloc>().add(GetTasks());
              },
              child: TextButton.icon(
                onPressed: null,
                icon: !task.isFavorite
                    ? const Icon(Icons.bookmark_add_outlined)
                    : const Icon(Icons.bookmark_remove),
                label: !task.isFavorite
                    ? const Text('Add to\nBookmarks')
                    : const Text('Remove from\nBookmarks'),
              ),
            ),
            // Temporal Removal
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(RemoveTaskTemporarily(task: task));
                context.read<TaskBloc>().add(GetTasks());
              },
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              ),
            ),
          ];
        } else {
          return <PopupMenuItem>[
            // Restoration
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(RestoreTask(task: task));
                context.read<TaskBloc>().add(GetTasks());
              },
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.restore_from_trash),
                label: const Text('Restore'),
              ),
            ),
            // Permanent Removal
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(RemoveTaskPermanently(task: task));
                context.read<TaskBloc>().add(GetTasks());
              },
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.delete_forever),
                label: const Text('Delete forever'),
              ),
            ),
          ];
        }
      },
    );
  }
}
