import 'package:flutter/foundation.dart';
import 'package:todo/app/home/domain/usecase/home_usecase.dart';
import 'package:todo/app/task_edit/data/model/task_model.dart';

class HomeController {
  final HomeUseCase useCase;

  HomeController(this.useCase);

  final ValueNotifier<List<Task>> tasksNotifier = ValueNotifier<List<Task>>([]);
  List<Task> get tasks => tasksNotifier.value;

  Future<void> fetchTasks() async {
    try {
      List<Task> tasks = await useCase.getTasks();
      tasksNotifier.value = tasks;
    } catch (e) {
      print("Erro ao buscar tasks: $e");
    }
  }
}
