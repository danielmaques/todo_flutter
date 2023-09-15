import 'package:flutter/material.dart';
import 'package:todo/app/task_edit/ui/controller/task_edit_controller.dart';

import '../../data/model/task_model.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({
    super.key,
    required this.controller,
  });

  final TasksController controller;

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Task Edit'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.link),
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
                controller: widget.controller.title,
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
                    widget.controller.title.text = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: widget.controller.note,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 20,
                decoration: const InputDecoration(
                  hintText: 'Anotações',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Adicione uma anotação';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    widget.controller.note.text = value!;
                  });
                },
              ),
              const Spacer(),
              Material(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Crie uma instância da tarefa
                      Task newTask = Task(
                        title: widget.controller.title.text,
                      ); // Adicione outros campos conforme necessário

                      // Adicione a tarefa usando o TasksController
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
                    }
                  },
                  highlightColor: Colors.blueAccent.withOpacity(0.5),
                  splashColor: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(13),
                  child: Ink(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Center(
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
