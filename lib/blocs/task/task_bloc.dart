import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
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

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    if (!task.isDone) {
      pendingTasks = List.from(pendingTasks)..remove(task);
      final completedTask = task.copyWith(isDone: true);
      completedTasks = List.from(completedTasks)..insert(0, completedTask);
    } else {
      completedTasks = List.from(completedTasks)..remove(task);
      final pendingTask = task.copyWith(isDone: false);
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

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
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

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
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
