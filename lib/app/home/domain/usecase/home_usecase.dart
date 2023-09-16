import '../../../task_edit/data/model/task_model.dart';

abstract class HomeUseCase {
  Future<List<Task>> getTasks();
}
