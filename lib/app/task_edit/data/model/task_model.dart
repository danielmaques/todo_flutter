import 'package:flutter/material.dart';

class Task {
  String? taskKey;
  String? title;
  String? note;
  List<TaskItem>? task;
  bool? isDone;

  Task({
    this.taskKey,
    required this.title,
    required this.note,
    required this.task,
    this.isDone = false,
  });

  Task.fromKeyAndMap(String key, Map<dynamic, dynamic> map)
      : taskKey = key,
        title = map['title'] as String?,
        note = map['note'] as String?,
        task = (map['task'] as List?)
            ?.map((item) => TaskItem.fromMap(item as Map<String, dynamic>))
            .toList(),
        isDone = map['isDone'] as bool?;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'task': task?.map((item) => item.toJson()).toList(),
      'isDone': isDone,
    };
  }
}

class TaskItem {
  bool isCheck;
  TextEditingController titleController;

  TaskItem({
    required this.isCheck,
    required this.titleController,
  });

  TaskItem.fromMap(Map<String, dynamic> map)
      : isCheck = map['isCheck'] as bool,
        titleController =
            TextEditingController(text: map['titleController'] as String);

  Map<String, dynamic> toJson() {
    return {
      'isCheck': isCheck,
      'titleController': titleController.text,
    };
  }
}
