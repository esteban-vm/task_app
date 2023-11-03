import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

class TaskMenu extends StatelessWidget {
  const TaskMenu({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return PopupMenuButton(
      itemBuilder: (_) {
        if (!task.isDeleted) {
          return <PopupMenuItem>[
            PopupMenuItem(
              onTap: () {},
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(ToggleFavoriteTask(task: task));
              },
              child: TextButton.icon(
                onPressed: null,
                icon: !task.isFavorite
                    ? const Icon(Icons.bookmark_add_outlined)
                    : const Icon(Icons.bookmark_remove),
                label: !task.isFavorite
                    ? const Text('Add to Bookmarks')
                    : const Text('Remove from Bookmarks'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(RemoveTaskTemporarily(task: task));
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
            PopupMenuItem(
              onTap: () {},
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.restore_from_trash),
                label: const Text('Restore'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                context.read<TaskBloc>().add(RemoveTaskPermanently(task: task));
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
