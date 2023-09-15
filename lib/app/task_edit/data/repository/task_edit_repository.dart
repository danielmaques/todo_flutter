import '../model/task_model.dart';

abstract class TaskEditRepository {
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
  Stream<List<Task>> getTasksStream();
}
