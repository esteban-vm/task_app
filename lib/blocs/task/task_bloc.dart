import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/repository/firestore_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<GetTasks>(_onGet);
    on<AddTask>(_onAdd);
    on<EditTask>(_onEdit);
    on<RestoreTask>(_onRestore);
    on<ToggleCompletedTask>(_onToggleCompleted);
    on<ToggleFavoriteTask>(_onToggleFavorite);
    on<RemoveTaskTemporarily>(_onRemoveTemporarily);
    on<RemoveTaskPermanently>(_onRemovePermanently);
    on<RemoveAllTasks>(_onRemoveAll);
  }

  Future<void> _onGet(
    GetTasks event,
    Emitter<TaskState> emit,
  ) async {
    final pendingTasks = <Task>[];
    final completedTasks = <Task>[];
    final favoriteTasks = <Task>[];
    final removedTasks = <Task>[];
    final tasks = await FirestoreRepository.getTasks();

    for (final task in tasks) {
      if (task.isRemoved) {
        removedTasks.add(task);
      } else {
        if (task.isFavorite) {
          favoriteTasks.add(task);
        }
        if (task.isCompleted) {
          completedTasks.add(task);
        } else {
          pendingTasks.add(task);
        }
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

  Future<void> _onAdd(
    AddTask event,
    Emitter<TaskState> emit,
  ) async {
    await FirestoreRepository.addTask(task: event.task);
  }

  Future<void> _onEdit(
    EditTask event,
    Emitter<TaskState> emit,
  ) async {
    await FirestoreRepository.updateTask(task: event.task);
  }

  Future<void> _onRestore(
    RestoreTask event,
    Emitter<TaskState> emit,
  ) async {
    final task = event.task.copyWith(
      date: DateTime.now().toString(),
      isCompleted: false,
      isRemoved: false,
      isFavorite: false,
    );
    await FirestoreRepository.updateTask(task: task);
  }

  Future<void> _onToggleCompleted(
    ToggleCompletedTask event,
    Emitter<TaskState> emit,
  ) async {
    var task = event.task;
    task = task.copyWith(isCompleted: !task.isCompleted);
    await FirestoreRepository.updateTask(task: task);
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteTask event,
    Emitter<TaskState> emit,
  ) async {
    var task = event.task;
    task = task.copyWith(isCompleted: !task.isFavorite);
    await FirestoreRepository.updateTask(task: task);
  }

  Future<void> _onRemoveTemporarily(
    RemoveTaskTemporarily event,
    Emitter<TaskState> emit,
  ) async {
    final task = event.task.copyWith(isRemoved: true);
    await FirestoreRepository.updateTask(task: task);
  }

  Future<void> _onRemovePermanently(
    RemoveTaskPermanently event,
    Emitter<TaskState> emit,
  ) async {
    await FirestoreRepository.deleteTask(task: event.task);
  }

  Future<void> _onRemoveAll(
    RemoveAllTasks event,
    Emitter<TaskState> emit,
  ) async {
    await FirestoreRepository.deleteAllTasks(tasks: state.removedTasks);
  }
}
