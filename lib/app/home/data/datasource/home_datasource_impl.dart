import 'package:firebase_database/firebase_database.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

import 'home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child('tasks');

  @override
  Future<List<Task>> listTasks() async {
    DatabaseEvent event = await _tasksRef.once();
    DataSnapshot snapshot = event.snapshot;
    List<Task> tasks = [];
    if (snapshot.value != null) {
      (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
        tasks.add(Task.fromSnapshot(snapshot.child(key.toString())));
      });
    }
    return tasks;
  }
}
