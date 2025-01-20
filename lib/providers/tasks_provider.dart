import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import 'package:uuid/uuid.dart';

class TasksProvider with ChangeNotifier {
  final StorageService _storageService;
  List<Task> _tasks = [];

  TasksProvider(this._storageService) {
    _loadTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> _loadTasks() async {
    _tasks = List<Task>.from(await _storageService.getTasks());
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
    );
    _tasks.add(task);
    await _storageService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> removeTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await _storageService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      await _storageService.saveTasks(_tasks);
      notifyListeners();
    }
  }
}
