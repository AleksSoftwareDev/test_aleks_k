// Description: This file defines the Task model class, which represents a task with an ID, title, and completion status.
class Task {
  final String id;
  final String title;
  final bool isDone;

  Task({required this.id, required this.title, this.isDone = false});

  Task copyWith({String? title, bool? isDone}) {
    return Task(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
