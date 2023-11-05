import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAdd);
    on<EditTask>(_onEdit);
    on<RestoreTask>(_onRestore);
    on<ToggleCompletedTask>(_onToggleCompleted);
    on<ToggleFavoriteTask>(_onToggleFavorite);
    on<RemoveTaskTemporarily>(_onRemoveTemporarily);
    on<RemoveTaskPermanently>(_onRemovePermanently);
    on<RemoveAllTasks>(_onRemoveAll);
  }

  void _onAdd(
    AddTask event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;

    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    pendingTasks = List.from(pendingTasks)..add(task);

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
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    if (oldTask.isFavorite) {
      favoriteTasks = favoriteTasks
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

  void _onRestore(
    RestoreTask event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;
    final restoredTask = task.copyWith(
      isCompleted: false,
      isRemoved: false,
      isFavorite: false,
    );

    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    pendingTasks = List.from(pendingTasks)..insert(0, restoredTask);
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

  void _onToggleCompleted(
    ToggleCompletedTask event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;

    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    final taskIndex = favoriteTasks.indexOf(task);

    if (!task.isCompleted) {
      final completedTask = task.copyWith(isCompleted: true);

      pendingTasks = List.from(pendingTasks)..remove(task);
      completedTasks = List.from(completedTasks)..insert(0, completedTask);

      if (task.isFavorite) {
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, completedTask);
      } else {
        favoriteTasks = List.from(favoriteTasks)..remove(task);
      }
    } else {
      final pendingTask = task.copyWith(isCompleted: false);

      pendingTasks = List.from(pendingTasks)..insert(0, pendingTask);
      completedTasks = List.from(completedTasks)..remove(task);

      if (task.isFavorite) {
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(taskIndex, pendingTask);
      } else {
        favoriteTasks = List.from(favoriteTasks)..remove(task);
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

  void _onToggleFavorite(
    ToggleFavoriteTask event,
    Emitter<TaskState> emit,
  ) {
    final task = event.task;
    final favoriteTask = task.copyWith(isFavorite: true);
    final unFavoriteTask = task.copyWith(isFavorite: false);

    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    if (!task.isCompleted) {
      final taskIndex = pendingTasks.indexOf(task);

      if (!task.isFavorite) {
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, favoriteTask);

        favoriteTasks = List.from(favoriteTasks)..insert(0, favoriteTask);
      } else {
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, unFavoriteTask);

        favoriteTasks = List.from(favoriteTasks)..remove(task);
      }
    } else {
      final taskIndex = completedTasks.indexOf(task);

      if (!task.isFavorite) {
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, favoriteTask);

        favoriteTasks = List.from(favoriteTasks)..insert(0, favoriteTask);
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, unFavoriteTask);

        favoriteTasks = List.from(favoriteTasks)..remove(task);
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

    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
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

  void _onRemoveAll(
    RemoveAllTasks event,
    Emitter<TaskState> emit,
  ) {
    var pendingTasks = state.pendingTasks;
    var completedTasks = state.completedTasks;
    var favoriteTasks = state.favoriteTasks;
    var removedTasks = state.removedTasks;

    removedTasks = List.from(removedTasks)..clear();

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
