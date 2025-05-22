import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    final taskNotifier = ref.read(taskListProvider.notifier);

    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: controller, decoration: InputDecoration(labelText: 'New Task')),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      taskNotifier.addTask(controller.text);
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final task = tasks[index];
                return TaskTile(task: task);
              },
            ),
          )
        ],
      ),
    );
  }
}
