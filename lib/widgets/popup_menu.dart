import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key,
    required this.task,
    required this.onToggleFavorite,
    required this.onRemoveTemporarily,
    required this.onRemovePermanently,
  });

  final Task task;
  final VoidCallback onToggleFavorite;
  final VoidCallback onRemoveTemporarily;
  final VoidCallback onRemovePermanently;

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
              onTap: onToggleFavorite,
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
              onTap: onRemoveTemporarily,
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
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.restore_from_trash),
                label: const Text('Restore'),
              ),
            ),
            PopupMenuItem(
              onTap: onRemovePermanently,
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
