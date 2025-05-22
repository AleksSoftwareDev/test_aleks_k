import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter_karpenko_aleks/src/feature/presentation/riverpod/task_provider.dart';

import '../widgets/task_tile.dart';

/// A simple task app using Riverpod for state management.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTask() {
    final taskNotifier = ref.read(taskListProvider.notifier);
    if (_controller.text.isNotEmpty) {
      taskNotifier.addTask(_controller.text);
      _controller.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added ✅')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Simple tasks')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Create a task',
                border: OutlineInputBorder(),
              ),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
