import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  String? taskKey;
  String? title;
  String? note;
  List<TaskItem>? task;
  bool? isDone;
  DateTime? scheduledTime;
  int? importanceLevel;

  Task({
    this.taskKey,
    required this.title,
    required this.note,
    required this.task,
    this.isDone = false,
    this.scheduledTime,
    this.importanceLevel,
  });

  Task.fromKeyAndMap(String key, Map<dynamic, dynamic> map)
      : taskKey = key,
        title = map['title'] as String?,
        note = map['note'] as String?,
        task = (map['task'] as List?)
            ?.map((item) => TaskItem.fromMap(item as Map<String, dynamic>))
            .toList(),
        isDone = map['isDone'] as bool?,
        scheduledTime = (map['scheduledTime'] as Timestamp?)?.toDate(),
        importanceLevel = map['importanceLevel'] as int?;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'task': task?.map((item) => item.toJson()).toList(),
      'isDone': isDone,
      'scheduledTime':
          scheduledTime != null ? Timestamp.fromDate(scheduledTime!) : null,
      'importanceLevel': importanceLevel,
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
