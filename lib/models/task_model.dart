// models/task_model.dart
class TaskModel {
  String id;
  String title;
  final String? description;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
  });

  // Convert from/to Firebase
  factory TaskModel.fromMap(Map<String, dynamic> data, String id) {
    return TaskModel(
      id: id,
      title: data['title'] ?? 'Sem título',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
