import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/home/data/datasource/home_datasource.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  Future<List<Task>> fetchTasks() async {
    QuerySnapshot snapshot = await _homeDataSource.getTasks();
    List<Task> tasks = [];

    for (var doc in snapshot.docs) {
      var taskData = doc.data() as Map<String, dynamic>;
      tasks.add(Task.fromKeyAndMap(doc.id, taskData));
    }

    return tasks;
  }
}
