import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/app/task_edit/ui/controller/task_edit_controller.dart';

import '../../data/model/task_model.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({
    Key? key,
    required this.controller,
    this.title,
    this.note,
    this.taskKey,
  }) : super(key: key);

  final TasksController controller;
  final String? title;
  final String? note;
  final String? taskKey;

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final _formKey = GlobalKey<FormState>();
  bool isCheck = false;
  List<TaskItem> taskItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.taskKey != null) {
      widget.controller.shareTaskList(widget.taskKey!);
    }
    if (widget.title != null) {
      widget.controller.title.value.text = widget.title!;
    }
    if (widget.note != null) {
      widget.controller.note.value.text = widget.note!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Task Edit'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(
                      text: widget.controller.sharedTaskLists.value));

                  if (await Clipboard.getData(Clipboard.kTextPlain) != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Link copiado para a área de transferência.'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.link),
              ),
              IconButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Task newTask = Task(
                      title: widget.controller.title.value.text,
                      note: widget.controller.note.value.text,
                      taskKey: widget.taskKey,
                      task: taskItems,
                    );

                    if (widget.title == null || widget.title!.isEmpty) {
                      widget.controller.addTask(newTask).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Tarefa adicionada com sucesso!')),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Erro ao adicionar tarefa: $error')),
                        );
                      });
                    } else {
                      widget.controller.updateTask(newTask).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Tarefa atualizada com sucesso!')),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Erro ao atualizar tarefa: $error')),
                        );
                      });
                    }
                  }
                },
                icon: const Icon(Icons.save),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.controller.title.value,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Título',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    widget.controller.title.value.text = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: widget.controller.note.value,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Descrição',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Adicione uma descrição';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    widget.controller.note.value.text = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: taskItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final taskItem = taskItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: taskItem.isCheck,
                            onChanged: (value) {
                              setState(() {
                                taskItem.isCheck = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: taskItem.titleController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                hintText: 'Tarefa',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            taskItems.add(TaskItem(
                isCheck: false, titleController: TextEditingController()));
          });
        },
        child: const Icon(
          Icons.check_box_outlined,
        ),
      ),
    );
  }
}
