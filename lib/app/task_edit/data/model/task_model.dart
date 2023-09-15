import 'package:firebase_database/firebase_database.dart';

class Task {
  final String? key;
  final String? title;
  final bool? isDone;

  Task({this.key, required this.title, this.isDone = false});

  Task.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = (snapshot.value as Map<String, dynamic>)['title'],
        isDone = (snapshot.value as Map<String, dynamic>)['isDone'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}
