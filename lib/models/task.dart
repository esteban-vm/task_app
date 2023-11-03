import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isRemoved = false,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final bool isRemoved;
  final bool isFavorite;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      date,
      isCompleted,
      isRemoved,
      isFavorite,
    ];
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isCompleted,
    bool? isRemoved,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isRemoved: isRemoved ?? this.isRemoved,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': isCompleted,
      'isRemoved': isRemoved,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      isCompleted: map['isCompleted'],
      isRemoved: map['isRemoved'],
      isFavorite: map['isFavorite'],
    );
  }
}
