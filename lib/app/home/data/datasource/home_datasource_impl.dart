import 'package:firebase_database/firebase_database.dart';

import 'home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('tasks');

  @override
  Future<DataSnapshot> getTasks() async {
    return (await _databaseReference.once()).snapshot;
  }
}
