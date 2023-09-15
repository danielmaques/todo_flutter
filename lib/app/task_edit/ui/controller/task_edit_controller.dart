import 'package:flutter/material.dart';
import 'package:todo/app/task_edit/data/repository/task_edit_repository.dart';
import '../../data/model/task_model.dart';

class TasksController {
  final TaskEditRepository _taskRepository;

  TextEditingController title = TextEditingController();

  TextEditingController note = TextEditingController();

  TasksController(this._taskRepository);

  // Obter um stream de tarefas
  Stream<List<Task>> get tasksStream {
    return _taskRepository.getTasksStream();
  }

  // Adicionar uma nova tarefa
  Future<void> addTask(Task task) {
    return _taskRepository.addTask(task);
  }

  // Atualizar uma tarefa existente
  Future<void> updateTask(Task task) {
    return _taskRepository.updateTask(task);
  }

  // Deletar uma tarefa
  Future<void> deleteTask(Task task) {
    return _taskRepository.deleteTask(task);
  }
}
