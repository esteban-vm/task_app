part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({this.tasks = const <Task>[]});
  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];

  Map<String, dynamic> toMap() {
    return {
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      tasks: List<Task>.from(
        map['tasks'].map<Task>((x) => Task.fromMap(x)),
      ),
    );
  }
}
