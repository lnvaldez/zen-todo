import "dart:convert";
import "package:shared_preferences/shared_preferences.dart";
import "../models/task.dart";

class StorageService {
  static const String _key = 'zen_tasks';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<List> getTasks() async {
    final String? tasksString = _prefs.getString(_key);
    if (tasksString == null) return [];

    final List decodedList = json.decode(tasksString);
    return decodedList.map((item) => Task.fromJson(item)).toList();
  }

  Future saveTasks(List tasks) async {
    final String encodedTasks = json.encode(
      tasks.map((task) => task.toJson()).toList(),
    );
    await _prefs.setString(_key, encodedTasks);
  }
}
