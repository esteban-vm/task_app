import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAdd);
    on<EditTask>(_onEdit);
    on<ToggleCompletedTask>(_onToggleCompleted);
    on<ToggleFavoriteTask>(_onToggleFavorite);
    on<RemoveTaskTemporarily>(_onRemoveTemporarily);
    on<RemoveTaskPermanently>(_onRemovePermanently);
  }

  void _onAdd(
    AddTask event,
    Emitter<TaskState> emit,
  ) {
    var pendingTasks = state.pendingTasks;
    final completedTasks = state.completedTasks;
    final favoriteTasks = state.favoriteTasks;
    final removedTasks = state.removedTasks;

    pendingTasks = List.from(pendingTasks)..add(event.task);

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  void _onEdit(
    EditTask event,
    Emitter<TaskState> emit,
  ) {
    final oldTask = event.oldTask;
    final newTask = event.newTask;
    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    final favoriteTasks = state.favoriteTasks;
    final removedTasks = state.removedTasks;

    if (oldTask.isFavorite) {
      favoriteTasks
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    pendingTasks = List.from(pendingTasks)
      ..remove(oldTask)
      ..insert(0, newTask);

    completedTasks = completedTasks..remove(oldTask);

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  void _onToggleCompleted(
    ToggleCompletedTask event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;
    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    final favoriteTasks = state.favoriteTasks;
    final removedTasks = state.removedTasks;

    if (!task.isCompleted) {
      pendingTasks = List.from(pendingTasks)..remove(task);
      final completedTask = task.copyWith(isCompleted: true);
      completedTasks = List.from(completedTasks)..insert(0, completedTask);
    } else {
      completedTasks = List.from(completedTasks)..remove(task);
      final pendingTask = task.copyWith(isCompleted: false);
      pendingTasks = List.from(pendingTasks)..insert(0, pendingTask);
    }

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  void _onToggleFavorite(
    ToggleFavoriteTask event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;
    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    final favoriteTasks = state.favoriteTasks;
    final removedTasks = state.removedTasks;

    if (!task.isCompleted) {
      final taskIndex = pendingTasks.indexOf(task);
      if (!task.isFavorite) {
        final favoriteTask = task.copyWith(isFavorite: true);
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, favoriteTask);
        favoriteTasks.insert(0, favoriteTask);
      } else {
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));
        favoriteTasks.remove(task);
      }
    } else {
      final taskIndex = completedTasks.indexOf(task);
      if (!task.isFavorite) {
        final favoriteTask = task.copyWith(isFavorite: true);
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, favoriteTask);
        favoriteTasks.insert(0, favoriteTask);
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));
        favoriteTasks.remove(task);
      }
    }

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  void _onRemoveTemporarily(
    RemoveTaskTemporarily event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;
    final removedTask = task.copyWith(isRemoved: true);
    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    pendingTasks = List.from(pendingTasks)..remove(task);
    completedTasks = List.from(completedTasks)..remove(task);
    favoriteTasks = List.from(favoriteTasks)..remove(task);
    removedTasks = List.from(removedTasks)..add(removedTask);

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  void _onRemovePermanently(
    RemoveTaskPermanently event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;
    final pendingTasks = state.pendingTasks;
    final completedTasks = state.completedTasks;
    final favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    removedTasks = List.from(removedTasks)..remove(task);

    emit(
      TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: removedTasks,
      ),
    );
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) => TaskState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TaskState state) => state.toMap();
}
