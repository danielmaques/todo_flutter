import '../../../task_edit/data/model/task_model.dart';

abstract class HomeDataSource {
  Future<List<Task>> listTasks();
}
