import 'package:flutter/material.dart';
import 'package:todo/app/task_edit/domain/usecase/task_edit_use_case.dart';

import '../../data/model/task_model.dart';

class TasksController {
  final TaskEditUseCase useCase;

  ValueNotifier<TextEditingController> title =
      ValueNotifier(TextEditingController());

  ValueNotifier<TextEditingController> note =
      ValueNotifier(TextEditingController());

  ValueNotifier<String> sharedTaskLists = ValueNotifier<String>('');

  TasksController(this.useCase);

  // Obter um stream de tarefas
  Stream<List<Task>> get tasksStream {
    return useCase.getTasksStream();
  }

  Future<void> addTask(Task task) {
    return useCase.addTask(task);
  }

  Future<void> updateTask(Task task) {
    return useCase.updateTask(task);
  }

  // Deletar uma tarefa
  Future<void> deleteTask(Task task) {
    return useCase.deleteTask(task);
  }
}
