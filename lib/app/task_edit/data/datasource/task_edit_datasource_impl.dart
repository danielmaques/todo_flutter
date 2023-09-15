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
    return _tasksRef.child(task.key!).update(task.toJson());
  }

  @override
  Future<void> deleteTask(Task task) {
    return _tasksRef.child(task.key!).remove();
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
}
