import 'package:todo/app/task_edit/data/model/task_model.dart';

import '../datasource/task_edit_datasource.dart';
import 'task_edit_repository.dart';

class TaskEditRepositoryImpl implements TaskEditRepository {
  final TaskEditDataSource _dataSource;

  TaskEditRepositoryImpl(this._dataSource);

  @override
  Future<void> addTask(task) {
    return _dataSource.addTask(task);
  }

  @override
  Future<void> deleteTask(task) {
    return _dataSource.deleteTask(task);
  }

  @override
  Future<void> updateTask(task) {
    return _dataSource.updateTask(task);
  }

  @override
  Stream<List<Task>> getTasksStream() {
    return _dataSource.getTasksStream();
  }
}
