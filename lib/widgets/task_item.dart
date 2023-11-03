import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/popup_menu.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                !task.isFavorite
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hms()
                            .format(DateTime.parse(task.date)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: task.isCompleted,
                onChanged: !task.isDeleted
                    ? (_) {
                        context
                            .read<TaskBloc>()
                            .add(ToggleCompletedTask(task: task));
                      }
                    : null,
              ),
              PopupMenu(
                task: task,
                onRemoveTemporarily: () {
                  context
                      .read<TaskBloc>()
                      .add(RemoveTaskTemporarily(task: task));
                },
                onRemovePermanently: () {
                  context
                      .read<TaskBloc>()
                      .add(RemoveTaskPermanently(task: task));
                },
                onToggleFavorite: () {
                  context.read<TaskBloc>().add(ToggleFavoriteTask(task: task));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
