import 'package:firebase_database/firebase_database.dart';
import 'package:todo/app/home/data/datasource/home_datasource.dart';

import '../../../task_edit/data/model/task_model.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  Future<List<Task>> fetchTasks() async {
    DataSnapshot snapshot = await _homeDataSource.getTasks();
    List<Task> tasks = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> tasksMap = snapshot.value as Map<dynamic, dynamic>;
      tasksMap.forEach((key, value) {
        var taskData = value as Map<dynamic, dynamic>;
        tasks.add(Task.fromKeyAndMap(key, taskData));
      });
    }

    return tasks;
  }
}
