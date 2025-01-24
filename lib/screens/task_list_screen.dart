// lib/screens/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import 'package:zen_todo/widgets/bouncing.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 135, 184, 136),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          final tasks = tasksProvider.tasks;

          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks yet. Add some!'),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        tasksProvider.removeTask(task.id);
                      },
                      backgroundColor: const Color.fromARGB(255, 135, 184, 136),
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    activeColor: const Color.fromARGB(255, 135, 184, 136),
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      tasksProvider.toggleTask(task.id);
                    },
                  ),
                  title: Text(task.title),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/task-detail',
                    arguments: task,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Bouncing(
        onPressed: () {},
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 135, 184, 136),
          foregroundColor: Colors.white,
          onPressed: _showAddTaskDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: 'Enter task title'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                context.read<TasksProvider>().addTask(_textController.text);
                _textController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
