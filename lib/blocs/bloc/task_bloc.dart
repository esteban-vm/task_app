import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    emit(TaskState(tasks: List.from(state.tasks)..add(event.task)));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    Task task = event.task;
    List<Task> tasks = List.from(state.tasks)..remove(task);
    int index = state.tasks.indexOf(task);
    tasks.insert(index, task.copyWith(isDone: !task.isDone));
    emit(TaskState(tasks: tasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    emit(TaskState(tasks: List.from(state.tasks)..remove(event.task)));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) => TaskState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TaskState state) => state.toMap();
}
