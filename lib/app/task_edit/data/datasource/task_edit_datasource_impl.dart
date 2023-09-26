import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

import 'task_edit_datasource.dart';

class TaskDataSourceImpl implements TaskEditDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addTask(Task task) {
    final Map<String, dynamic> taskData = {
      'title': task.title,
      'note': task.note,
      'task': task.task?.map((item) => item.toJson()).toList(),
      'isDone': task.isDone,
      'scheduledTime': task.scheduledTime?.toUtc(),
      'importanceLevel': task.importanceLevel,
    };

    return _firestore.collection('tasks').add(taskData);
  }

  @override
  Future<void> updateTask(Task task) {
    if (task.taskKey == null) {
      throw ArgumentError(
          'A chave da tarefa não pode ser nula ao atualizar a tarefa.');
    }

    final Map<String, dynamic> taskData = {
      'title': task.title,
      'note': task.note,
      'task': task.task?.map((item) => item.toJson()).toList(),
      'isDone': task.isDone,
      'scheduledTime': task.scheduledTime?.toUtc(),
      'importanceLevel': task.importanceLevel,
    };

    return _firestore.collection('tasks').doc(task.taskKey!).set(taskData);
  }

  @override
  Future<void> deleteTask(Task task) {
    return _firestore.collection('tasks').doc(task.taskKey!).delete();
  }

  @override
  Stream<List<Task>> getTasksStream() {
    return _firestore.collection('tasks').snapshots().map((snapshot) {
      List<Task> tasks = [];
      for (var doc in snapshot.docs) {
        var taskData = doc.data();
        tasks.add(Task.fromKeyAndMap(doc.id, taskData));
      }
      return tasks;
    });
  }
}
