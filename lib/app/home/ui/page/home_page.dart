import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../task_edit/data/model/task_model.dart';
import '../controller/home_controller.dart';
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
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (taskId) {
                // widget.controller.filterTasksByName(taskId);
              },
              decoration: const InputDecoration(
                hintText: 'Buscar tarefa',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<List<Task>>(
              valueListenable: widget.controller.tasksNotifier,
              builder: (context, List<Task> tasks, child) {
                final validTasks =
                    tasks.where((task) => task.title != null).toList();

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: validTasks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final task = validTasks[index];
                    return TaskWidget(
                      title: task.title ?? '',
                      onTap: () {
                        Modular.to.pushNamed(
                          '/taskEdit/',
                          arguments: {
                            'title': task.title,
                            'note': task.note,
                            'taskKey': task.taskKey,
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Modular.to.pushNamed(
            '/taskEdit/',
          );
        },
      ),
    );
  }
}
