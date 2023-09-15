import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/home/ui/controller/home_controller.dart';

import '../../../task_edit/data/model/task_model.dart';
import '../widgets/task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.controller.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listas de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ValueListenableBuilder<List<Task>>(
          valueListenable: widget.controller.tasksNotifier,
          builder: (context, List<Task> tasks, child) => ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskWidget(
                title: task
                    .title!, // Supondo que TaskWidget aceite um parâmetro 'title'
                onTap: () {
                  Modular.to.pushNamed(
                    '/taskEdit/',
                    arguments: {
                      'title': task.title,
                      'taskKey': task.taskKey,
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
