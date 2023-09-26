import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<QuerySnapshot> getTasks() async {
    return await _tasksCollection.get();
  }
}
