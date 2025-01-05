// viewmodels/task_view_model.dart
import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/firebase_service.dart';

class TaskViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchTasks() async {
    _isLoading = true;

    try {
      _tasks = await _firebaseService.fetchTasks();
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar tarefas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String title, String description) async {
    if (title.isEmpty) return;
    final task = TaskModel(id: '', title: title, description: description);
    final docRef = await _firebaseService.addTask(task);
    task.id = docRef.id;
    await fetchTasks();
  }

  Future<void> toggleTaskCompletion(TaskModel task) async {
    task.isCompleted = !task.isCompleted;
    await _firebaseService.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(String id) async {
    await _firebaseService.deleteTask(id);
    await fetchTasks();
  }
}
