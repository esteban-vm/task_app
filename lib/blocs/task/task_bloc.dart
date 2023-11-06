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
  ) {}

  void _onEdit(
    EditTask event,
    Emitter<TaskState> emit,
  ) {}

  void _onRestore(
    RestoreTask event,
    Emitter<TaskState> emit,
  ) {}

  void _onToggleCompleted(
    ToggleCompletedTask event,
    Emitter<TaskState> emit,
  ) {}

  void _onToggleFavorite(
    ToggleFavoriteTask event,
    Emitter<TaskState> emit,
  ) {}

  void _onRemoveTemporarily(
    RemoveTaskTemporarily event,
    Emitter<TaskState> emit,
  ) {}

  void _onRemovePermanently(
    RemoveTaskPermanently event,
    Emitter<TaskState> emit,
  ) {}

  void _onRemoveAll(
    RemoveAllTasks event,
    Emitter<TaskState> emit,
  ) {}

  @override
  TaskState? fromJson(Map<String, dynamic> json) => TaskState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(TaskState state) => state.toMap();
}
