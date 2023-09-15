import 'package:flutter/foundation.dart';

import '../../../task_edit/data/model/task_model.dart';
import '../../domain/usecase/home_usecase.dart';

class HomeController {
  final HomeUseCase _homeUseCase;

  HomeController(this._homeUseCase);

  final ValueNotifier<List<Task>> tasksNotifier = ValueNotifier<List<Task>>([]);

  void fetchTasks() async {
    tasksNotifier.value = await _homeUseCase.listTasks();
  }
}
