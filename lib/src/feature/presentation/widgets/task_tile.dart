import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/task.dart';
import '../riverpod/task_provider.dart';

/// A widget that represents a single task tile in the task list.

class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskListProvider.notifier);

    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null),
      ),
      leading: Checkbox(
        value: task.isDone,
        onChanged: (_) {
          taskNotifier.toggleTask(task.id);

          if (!task.isDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Nice! Task is done 🎉'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => taskNotifier.deleteTask(task.id),
      ),
    );
  }
}
