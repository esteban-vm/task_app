part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TaskEvent {
  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  const AddTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent {
  const EditTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class RestoreTask extends TaskEvent {
  const RestoreTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class ToggleCompletedTask extends TaskEvent {
  const ToggleCompletedTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class ToggleFavoriteTask extends TaskEvent {
  const ToggleFavoriteTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class RemoveTaskTemporarily extends TaskEvent {
  const RemoveTaskTemporarily({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class RemoveTaskPermanently extends TaskEvent {
  const RemoveTaskPermanently({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class RemoveAllTasks extends TaskEvent {}
