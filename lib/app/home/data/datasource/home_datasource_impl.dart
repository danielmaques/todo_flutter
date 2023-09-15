import 'package:firebase_database/firebase_database.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

import 'home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child('tasks');

  @override
  Future<List<Task>> listTasks() async {
    final DataSnapshot snapshot = (await _tasksRef.once()).snapshot;

    List<Task> tasks = [];

    if (snapshot.value is Map) {
      Map<dynamic, dynamic> rawTasksData =
          snapshot.value as Map<dynamic, dynamic>;

      rawTasksData.forEach((key, value) {
        if (key is String && value is Map) {
          Map<String, dynamic> taskData = Map<String, dynamic>.from(value);
          taskData['taskKey'] = key; // Adicionando o 'taskKey' ao mapa
          tasks.add(Task.fromMap(taskData));
        }
      });
    }

    return tasks;
  }
}
