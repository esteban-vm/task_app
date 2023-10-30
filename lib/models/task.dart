import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.title,
    this.isDone = false,
    this.isDeleted = false,
  });

  final String id;
  final String title;
  final bool isDone;
  final bool isDeleted;

  Task copyWith({
    String? id,
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? false,
      isDeleted: isDeleted ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, title, isDone, isDeleted];
}
