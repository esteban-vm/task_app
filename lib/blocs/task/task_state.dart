part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;
  final List<Task> removedTasks;

  @override
  List<Object> get props {
    return [
      pendingTasks,
      completedTasks,
      favoriteTasks,
      removedTasks,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': completedTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      pendingTasks: List<Task>.from(
        map['pendingTasks']?.map((x) => Task.fromMap(x)),
      ),
      completedTasks: List<Task>.from(
        map['completedTasks']?.map((x) => Task.fromMap(x)),
      ),
      favoriteTasks: List<Task>.from(
        map['favoriteTasks']?.map((x) => Task.fromMap(x)),
      ),
      removedTasks: List<Task>.from(
        map['removedTasks']?.map((x) => Task.fromMap(x)),
      ),
    );
  }
}
