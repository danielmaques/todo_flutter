import 'package:todo/app/home/domain/usecase/home_usecase.dart';

import '../../../task_edit/data/model/task_model.dart';

class HomeController {
  final HomeUseCase _homeUseCase;

  HomeController(this._homeUseCase);

  Future<List<Task>> listTasks() => _homeUseCase.listTasks();
}
