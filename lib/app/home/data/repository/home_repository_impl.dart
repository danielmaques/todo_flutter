import 'package:todo/app/home/data/datasource/home_datasource.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl(this._homeDataSource);

  @override
  Future<List<Task>> listTasks() {
    return _homeDataSource.listTasks();
  }
}
