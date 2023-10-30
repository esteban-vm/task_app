part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  const AddTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  const UpdateTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  const DeleteTask({required this.task});
  final Task task;

  @override
  List<Object> get props => [task];
}
