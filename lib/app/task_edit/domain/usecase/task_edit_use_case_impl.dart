import 'package:todo/app/task_edit/data/model/task_model.dart';

import '../../data/repository/task_edit_repository.dart';
import 'task_edit_use_case.dart';

class TaskEditUseCaseImpl implements TaskEditUseCase {
  final TaskEditRepository _taskEditRepository;

  TaskEditUseCaseImpl(this._taskEditRepository);

  @override
  Future<void> addTask(Task task) {
    return _taskEditRepository.addTask(task);
  }

  @override
  Future<void> deleteTask(Task task) {
    return _taskEditRepository.deleteTask(task);
  }

  @override
  Future<void> updateTask(Task task) {
    return _taskEditRepository.updateTask(task);
  }

  @override
  Stream<List<Task>> getTasksStream() {
    return _taskEditRepository.getTasksStream();
  }

  @override
  Future<String> shareTaskList(String taskListId) {
    return _taskEditRepository.shareTaskList(taskListId);
  }
}
