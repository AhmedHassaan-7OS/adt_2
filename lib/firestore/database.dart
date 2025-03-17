import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoDataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      QuerySnapshot todoSnapshot = await _firestore.collection('todos').get();
      return todoSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'task': doc['task'],
          'completed': doc['completed'],
        };
      }).toList();
    } catch (e) {
      print("Error loading data: $e");
      return [];
    }
  }

  Future<void> addTask(String task) async {
    await _firestore.collection('todos').add({
      'task': task,
      'completed': false,
    });
  }

  Future<void> toggleTaskCompletion(String id, bool completed) async {
    try {
      await _firestore.collection('todos').doc(id).update({
        'completed': completed,
      });
      print("Task completion toggled successfully!");
    } catch (e) {
      print("Error toggling task completion: $e");
    }
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }
}