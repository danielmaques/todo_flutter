import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasource/task_edit_datasource.dart';
import 'data/datasource/task_edit_datasource_impl.dart';
import 'data/repository/task_edit_repository.dart';
import 'data/repository/task_edit_repository_impl.dart';
import 'domain/usecase/task_edit_use_case.dart';
import 'domain/usecase/task_edit_use_case_impl.dart';
import 'ui/controller/task_edit_controller.dart';
import 'ui/page/task_edit_page.dart';

class TaskEditModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<TaskEditDataSource>(TaskDataSourceImpl.new);
    i.addSingleton<TaskEditRepository>(TaskEditRepositoryImpl.new);
    i.addSingleton<TaskEditUseCase>(TaskEditUseCaseImpl.new);
    i.addSingleton(TasksController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => TaskEditPage(
        controller: Modular.get<TasksController>(),
        title: r.args.data?['title'] ?? '',
        note: r.args.data?['note'] ?? '',
        taskKey: r.args.data?['taskKey'] ?? '',
      ),
    );
  }
}
