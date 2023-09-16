import 'package:firebase_database/firebase_database.dart';

abstract class HomeDataSource {
  Future<DataSnapshot> getTasks();
}
