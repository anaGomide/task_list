// services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class FirebaseService {
  final CollectionReference _taskCollection = FirebaseFirestore.instance.collection('tasks');

  Future<List<TaskModel>> fetchTasks() async {
    print('Fetching tasks...');
    try {
      final snapshot = await _taskCollection.get();
      print('Fetched ${snapshot.docs.length} tasks');
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromMap(data, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar tarefas: $e');
    }
  }

  Future<DocumentReference> addTask(TaskModel task) async {
    return await _taskCollection.add(task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskCollection.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }
}
