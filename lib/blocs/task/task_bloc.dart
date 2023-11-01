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
    List<Task> allTasks = List.from(state.allTasks)..add(event.task);
    List<Task> removedTasks = state.removedTasks;
    emit(TaskState(allTasks: allTasks, removedTasks: removedTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final task = event.task;
    final updatedTask = task.copyWith(isDone: !task.isDone);
    final taskIndex = state.allTasks.indexOf(task);
    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    allTasks.insert(taskIndex, updatedTask);
    List<Task> removedTasks = state.removedTasks;
    emit(TaskState(allTasks: allTasks, removedTasks: removedTasks));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final task = event.task;
    final removedTask = task.copyWith(isDeleted: true);
    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    List<Task> removedTasks = List.from(state.removedTasks)..add(removedTask);
    emit(TaskState(allTasks: allTasks, removedTasks: removedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    List<Task> allTasks = state.allTasks;
    List<Task> removedTasks = List.from(state.removedTasks)..remove(event.task);
    emit(TaskState(allTasks: allTasks, removedTasks: removedTasks));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) => TaskState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TaskState state) => state.toMap();
}
