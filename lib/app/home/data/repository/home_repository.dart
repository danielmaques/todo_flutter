import '../../../task_edit/data/model/task_model.dart';

abstract class HomeRepository {
  Future<List<Task>> listTasks();
}
