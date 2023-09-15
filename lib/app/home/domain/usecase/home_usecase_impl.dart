import 'package:todo/app/task_edit/data/model/task_model.dart';

import '../../data/repository/home_repository.dart';
import 'home_usecase.dart';

class HomeUseCaseImpl implements HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);
  @override
  Future<List<Task>> listTasks() {
    return _homeRepository.listTasks();
  }
}
