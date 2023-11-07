import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/models/task.dart';

class FirestoreRepository {
  static CollectionReference<Map<String, dynamic>> get _data {
    final email = GetStorage().read('email');
    final store = FirebaseFirestore.instance;
    return store.collection(email);
  }

  static Future<List<Task>> getTasks() async {
    try {
      final tasks = <Task>[];
      final snapshot = await _data.get();

      for (final task in snapshot.docs) {
        tasks.add(Task.fromMap(task.data()));
      }

      return tasks;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> addTask({required Task task}) async {
    try {
      await _data.doc(task.id).set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> updateTask({required Task task}) async {
    try {
      await _data.doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteTask({required Task task}) async {
    try {
      await _data.doc(task.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteAllTasks({required List<Task> tasks}) async {
    try {
      for (final task in tasks) {
        await _data.doc(task.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
