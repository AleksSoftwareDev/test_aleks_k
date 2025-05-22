import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/task.dart';

/// This provider manages the state of the task list

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void addTask(String title) {
    final newTask = Task(id: const Uuid().v4(), title: title);
    state = [...state, newTask];
  }

  void toggleTask(String id) {
    state = state.map((task) {
      return task.id == id ? task.copyWith(isDone: !task.isDone) : task;
    }).toList();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}
