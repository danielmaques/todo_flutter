import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

import 'task_edit_datasource.dart';

class TaskDataSourceImpl implements TaskEditDataSource {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child('tasks');

  @override
  Future<void> addTask(Task task) {
    return _tasksRef.push().set(task.toJson());
  }

  @override
  Future<void> updateTask(Task task) {
    if (task.taskKey == null) {
      throw ArgumentError(
          'A chave da tarefa não pode ser nula ao atualizar a tarefa.');
    }
    return _tasksRef.child(task.taskKey!).update(task.toJson());
  }

  @override
  Future<void> deleteTask(Task task) {
    return _tasksRef.child(task.taskKey!).remove();
  }

  @override
  Stream<List<Task>> getTasksStream() {
    return _tasksRef.onValue.map((event) {
      List<Task> tasks = [];
      if (event.snapshot.value != null) {
        (event.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
          tasks.add(Task.fromSnapshot(event.snapshot.child(key)));
        });
      }
      return tasks;
    });
  }

  String _generateUniqueCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(8, (index) => chars[Random().nextInt(chars.length)])
        .join();
  }

  @override
  Future<String> shareTaskList(String taskListId) async {
    final uniqueCode = _generateUniqueCode();

    await _tasksRef.child('sharedTaskLists').child(uniqueCode).set(taskListId);

    return uniqueCode;
  }
}
