import 'package:firebase_database/firebase_database.dart';

class Task {
  final String? taskKey;
  final String? title;
  final bool? isDone;

  Task({this.taskKey, required this.title, this.isDone = false});

  Task.fromSnapshot(DataSnapshot snapshot)
      : taskKey = snapshot.key,
        title = snapshot.value is Map
            ? (snapshot.value as Map<dynamic, dynamic>)['title'] as String?
            : null,
        isDone = snapshot.value is Map
            ? (snapshot.value as Map<dynamic, dynamic>)['isDone'] as bool?
            : null;

  Task.fromMap(Map<String, dynamic> map)
      : taskKey = map['taskKey'] as String?, 
        title = map['title'] as String?,
        isDone = map['isDone'] as bool?;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}
