import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAdd);
    on<ToggleCompletedTask>(_onToggleCompleted);
    on<ToggleFavoriteTask>(_onToggleFavorite);
    on<RemoveTaskTemporarily>(_onRemoveTemporarily);
    on<RemoveTaskPermanently>(_onRemovePermanently);
  }

  void _onAdd(
    AddTask event,
    Emitter<TaskState> emit,
  ) {
    List<Task> pendingTasks = List.from(state.pendingTasks)..add(event.task);
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    List<Task> removedTasks = state.removedTasks;

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
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    if (!task.isCompleted) {
      pendingTasks = List.from(pendingTasks)..remove(task);
      final completedTask = task.copyWith(isCompleted: true);
      completedTasks = List.from(completedTasks)..insert(0, completedTask);
    } else {
      completedTasks = List.from(completedTasks)..remove(task);
      final pendingTask = task.copyWith(isCompleted: false);
      pendingTasks = List.from(pendingTasks)..insert(0, pendingTask);
    }

    List<Task> favoriteTasks = state.favoriteTasks;
    List<Task> removedTasks = state.removedTasks;

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
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

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

    List<Task> removedTasks = state.removedTasks;

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
    final removedTask = task.copyWith(isDeleted: true);
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    List<Task> removedTasks = state.removedTasks;
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
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    List<Task> removedTasks = List.from(state.removedTasks)..remove(event.task);

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
