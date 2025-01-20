import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/task_list_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/quotes_screen.dart';
import 'services/storage_service.dart';
import 'providers/tasks_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);

  runApp(
    ChangeNotifierProvider(
      create: (_) => TasksProvider(storageService),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zen Todo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffc7d4c0),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/tasks': (context) => const TaskListScreen(),
        '/task-detail': (context) => const TaskDetailScreen(),
        '/quotes': (context) => const QuotesScreen(),
      },
    );
  }
}
