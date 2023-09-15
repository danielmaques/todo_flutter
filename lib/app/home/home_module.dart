import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/home/data/datasource/home_datasource_impl.dart';
import 'package:todo/app/home/data/repository/home_repository.dart';
import 'package:todo/app/home/domain/usecase/home_usecase.dart';
import 'package:todo/app/home/domain/usecase/home_usecase_impl.dart';
import 'package:todo/app/home/ui/controller/home_controller.dart';

import 'data/datasource/home_datasource.dart';
import 'data/repository/home_repository_impl.dart';
import 'ui/page/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<HomeDataSource>(HomeDataSourceImpl.new);
    i.addSingleton<HomeRepository>(HomeRepositoryImpl.new);
    i.addSingleton<HomeUseCase>(HomeUseCaseImpl.new);
    i.addSingleton<HomeController>(HomeController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) =>
            HomePage(controller: Modular.get<HomeController>()));
  }
}
